import Foundation
import SlackKit

class RobotOrNotBot {
    
    let verdicts: [String:Bool] = [
        "Mr. Roboto" : false,
        "Service Kiosks": false,
        "Darth Vader": false,
        "K-9": true,
        "Emotions": false,
        "Self-Driving Cars": false,
        "Telepresence Robots": false,
        "Roomba": true,
        "Assembly-Line Robot": false,
        "ASIMO": false,
        "KITT": false,
        "USS Enterprise": false,
        "Transformers": true,
        "Jaegers": false,
        "The Major": false,
        "Siri": false,
        "The Terminator": true,
        "Commander Data": false,
        "Marvin the Paranoid Android": true,
        "Pinocchio": false,
        "Droids": true,
        "Hitchbot": false,
        "Mars Rovers": false,
        "Space Probes": false,
        "Sasquatch": false,
        "Toaster": false,
        "Toaster Oven": false,
        "Cylons": false,
        "V'ger": true,
        "Ilia Robot": false,
        "The TARDIS": false,
        "Johnny 5": true,
        "Twiki": true,
        "Dr. Theopolis": false,
        "robots.txt": false,
        "Lobot": false,
        "Vicki": true,
        "GlaDOS": false,
        "Turrets": true,
        "Wheatley": true,
        "Herbie the Love Bug": false,
        "Iron Man": false,
        "Ultron": false,
        "The Vision": false,
        "Clockwork Droids": false,
        "Podcasts": false,
        "Cars": false,
        "Swimming Pool Cleaners": false,
        "Burritos": false,
        "Prince Robot IV": false,
        "Daleks": false,
        "Cybermen": false,
        "The Internet of Things": false,
        "Nanobots": true,
        "Two Intermeshed Gears": false,
        "Crow T. Robot": true,
        "Tom Servo": true,
        "Thomas and Friends": false,
        "Replicants": false,
        "Chatbots": false,
        "Agents": false,
        "Lego Simulated Worm Toy": true,
        "Ghosts": false,
        "Exos": true,
        "Rasputin": false,
        "Tamagotchi": false,
        "T-1000": true,
        "The Tin Woodman": false,
        "Mic N. The Robot": true,
        "Robot Or Not Bot": false
    ]
    
    let bot: SlackKit
    
    init(token: String) {
        bot = SlackKit()
        bot.addRTMBotWithAPIToken(token)
        bot.addWebAPIAccessWithToken(token)
        bot.notificationForEvent(.message) { [weak self] (event, connection) in
            guard
                let message = event.message,
                let id = connection?.client?.authenticatedUser?.id,
                message.text?.contains(id) == true
            else {
                return
            }
            self?.handleMessage(message)
        }
    }
    
    init(clientID: String, clientSecret: String) {
        bot = SlackKit()
        let oauthConfig = OAuthConfig(clientID: clientID, clientSecret: clientSecret)
        bot.addServer(oauth: oauthConfig)
        bot.notificationForEvent(.message) { [weak self] (event, connection) in
            guard
                let message = event.message,
                let id = connection?.client?.authenticatedUser?.id,
                message.text?.contains(id) == true
            else {
                return
            }
            self?.handleMessage(message)
        }
    }
    
    // MARK: Bot logic
    private func handleMessage(_ message: Message) {
        if let text = message.text?.lowercased(), let channel = message.channel {
            for (robot, verdict) in verdicts {
                let lowerbot = robot.lowercased()
                if text.contains(lowerbot) {
                    let reaction = verdict ? "robot_face" : "no_entry_sign"
                    bot.webAPI?.addReactionToMessage(name: reaction, channel: channel, timestamp: message.ts!, success: nil, failure: nil)
                    return
                }
            }
            // Not found
            bot.webAPI?.addReactionToMessage(name: "question", channel: channel, timestamp: message.ts!, success: nil, failure: nil)
            return
        }
    }
}

// With API token
let slackbot = RobotOrNotBot(token: "xoxb-SLACK_API_TOKEN")
// With OAuth
// let slackbot = RobotOrNotBot(clientID: "CLIENT_ID", clientSecret: "CLIENT_SECRET")
RunLoop.main.run()
