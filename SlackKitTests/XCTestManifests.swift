import XCTest

extension SKCoreTests {
    static let __allTests = [
        ("testChannel", testChannel),
        ("testConversation", testConversation),
        ("testEvents", testEvents),
        ("testFile", testFile),
        ("testGroup", testGroup),
        ("testIm", testIm),
        ("testMpim", testMpim),
        ("testUser", testUser),
        ("testUserGroup", testUserGroup),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SKCoreTests.__allTests),
    ]
}
#endif
