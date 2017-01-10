import XCTest
@testable import FileUtilsTests

XCTMain([
     testCase(DirectoryTests.allTests),
     testCase(FileTests.allTests),
     testCase(PathTests.allTests),
])
