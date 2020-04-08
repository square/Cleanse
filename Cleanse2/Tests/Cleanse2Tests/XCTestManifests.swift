import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Cleanse2Tests.allTests),
    ]
}
#endif
