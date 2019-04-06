//
// Leaderboard.swift
//
// Copyright © 2019 Peter Zignego. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import SlackKit

class Leaderbot {
    
    struct Leaderboard {
        let teamID: String
        var scores = [String: Int]()
        
        init(teamID: String) {
            self.teamID = teamID
        }
    }
    
    enum Command: String {
        case leaderboard = "leaderboard"
    }
    
    enum Trigger: String {
        case plusPlus = "++"
        case minusMinus = "--"
    }
    
    let slackkit = SlackKit()

    var leaderboards = [String: Leaderboard]()
    let atSet = CharacterSet(charactersIn: "@")
    
    init(apiToken: String) {
        slackkit.addWebAPIAccessWithToken(apiToken)
        slackkit.addRTMBotWithAPIToken(apiToken)
        slackkit.notificationForEvent(.message) { [weak self] (event, client) in
            self?.listen(client?.client, message: event.message)
        }
    }
    
    init(clientID: String, clientSecret: String) {
        let oauthConfig = OAuthConfig(clientID: clientID, clientSecret: clientSecret)
        slackkit.addServer(oauth: oauthConfig)
        slackkit.notificationForEvent(.message) { [weak self] (event, client) in
            self?.listen(client?.client, message: event.message)
        }
    }
    
    // MARK: Leaderboard Internal Logic
    private func listen(_ client: Client?, message: Message?) {
        guard let message = message, let text = message.text, let client = client else {
            return
        }
        switch text {
        case let text where text.lowercased().contains(Command.leaderboard.rawValue) && text.optionalContains(client.authenticatedUser?.id):
            handleCommand(.leaderboard, channel: message.channel, client: client)
        case let text where text.contains(Trigger.plusPlus.rawValue):
            handleMessageWithTrigger(.plusPlus, message: message, client: client)
        case let text where text.contains(Trigger.minusMinus.rawValue):
            handleMessageWithTrigger(.minusMinus, message: message, client: client)
        default:
            break
        }
    }
    
    private func handleMessageWithTrigger(_ trigger: Trigger, message: Message, client: Client) {
        guard
            let text = message.text,
            let teamID = client.team?.id
        else {
            return
        }
        if leaderboards[teamID] == nil { leaderboards[teamID] = Leaderboard(teamID: teamID) }
        //Nonusers
        searchTextWithExpression("([a-z0-9_\\-\\.]+)[\\+\\-]{2}", text: text, trigger: trigger, teamID:  teamID)
        //Users
        searchTextWithExpression("<@([A-Z0-9_\\-\\.]+)>[\\+\\-]{2}", text: text, trigger: trigger, teamID:  teamID)
    }
    
    func searchTextWithExpression(_ expression: String, text: String, trigger: Trigger, teamID: String) {
        let thingRegex = try? NSRegularExpression(pattern: expression, options: [])
        let things = thingRegex?.matches(in: text, options: [], range: NSMakeRange(0, text.utf16.count)) ?? []
        for match in things {
            let value = String(text[text.range(from: match.range(at: 1))!])
            if leaderboards[teamID]?.scores[value] == nil { leaderboards[teamID]?.scores[value] = 0 }
            switch trigger {
            case .plusPlus:
                leaderboards[teamID]?.scores[value]?+=1
            case .minusMinus:
                leaderboards[teamID]?.scores[value]?-=1
            }
        }
    }
    
    private func handleCommand(_ command: Command, channel:String?, client: Client) {
        switch command {
        case .leaderboard:
            if let id = channel {
                slackkit.webAPI?.sendMessage(channel: id,
                                             text: "Here's the leaderboard:",
                                             linkNames: true,
                                             attachments: [constructLeaderboardAttachment(client)],
                                             success: nil,
                                             failure: { (error) in
                                                print("Leaderboard failed to post due to error:\(error)")
                })
            }
        }
    }

    // MARK: Leaderboard Interface
    private func constructLeaderboardAttachment(_ client: Client) -> Attachment? {
        guard let teamID = client.team?.id, let leaderboard = leaderboards[teamID] else {
            return nil
        }
        let top = AttachmentField(title: ":100:", value: swapIDsForNames(client, string: topItems(leaderboard)), short: true)
        let bottom = AttachmentField(title: ":poop:", value: swapIDsForNames(client, string: bottomItems(leaderboard)), short: true)
        return Attachment(fallback: "Leaderboard", title: "Leaderboard", colorHex: AttachmentColor.good.rawValue, text: "", fields: [top, bottom])
    }
    
    private func topItems(_ leaderboard: Leaderboard) -> String {
        let sortedKeys = Array(leaderboard.scores.keys).sorted(by: {leaderboard.scores[$0]! > leaderboard.scores[$1]!}).filter({leaderboard.scores[$0]! > 0})
        let sortedValues = Array(leaderboard.scores.values).sorted(by: {$0 > $1}).filter({$0 > 0})
        return leaderboardString(sortedKeys, values: sortedValues)
    }
    
    private func bottomItems(_ leaderboard: Leaderboard) -> String {
        let sortedKeys = Array(leaderboard.scores.keys).sorted(by: {leaderboard.scores[$0]! < leaderboard.scores[$1]!}).filter({leaderboard.scores[$0]! < 0})
        let sortedValues = Array(leaderboard.scores.values).sorted(by: {$0 < $1}).filter({$0 < 0})
        return leaderboardString(sortedKeys, values: sortedValues)
    }
    
    private func leaderboardString(_ keys: [String], values: [Int]) -> String {
        var returnValue = ""
        for i in 0..<values.count {
            returnValue += keys[i] + " (" + "\(values[i])" + ")\n"
        }
        return returnValue
    }
    
    // MARK: - Utilities
    private func swapIDsForNames(_ client: Client, string: String) -> String {
        var returnString = string
        for key in client.users.keys {
            if let name = client.users[key]?.name {
                returnString = returnString.replacingOccurrences(of: key, with: "@"+name, options: NSString.CompareOptions.literal, range: returnString.startIndex..<returnString.endIndex)
            }
        }
        return returnString
    }
}

extension String {
    func optionalContains(_ string: String?) -> Bool {
        guard let str = string else {
            return false
        }
        return self.contains(str)
    }
}

extension String {
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = from16.samePosition(in: self),
            let to = to16.samePosition(in: self)
            else { return nil }
        return from ..< to
    }
}
