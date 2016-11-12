import XCTest
@testable import SwiftFile

class FileTests: XCTestCase {
  
  func testItGetsTempPath() {
    let tmp = SwiftPath.tempFolder
      XCTAssertEqual(tmp.contains("/var/folders"), true)
  }
  
  func testItGetsTempFilePath() {
    let tmp = SwiftPath.tempFileName(name: "abc.txt")
    XCTAssertEqual(tmp.contains("/var/folders"), true)
    XCTAssertEqual(tmp.contains("abc.txt"), true)
  }
  
  func testItGetsRandomTempFilePath() {
    let tmp = SwiftPath.tempFile
    XCTAssertEqual(tmp.contains("/var/folders"), true)
  }
  
  func testsFileExistsCreateAndDelete() {
    let tmp = SwiftPath.tempFile
    XCTAssertEqual(SwiftFile.exists(path: tmp), false)
    _ = SwiftFile(path: tmp, fileMode: .write)
    XCTAssertEqual(SwiftFile.exists(path: tmp), true)
    
    SwiftFile.delete(string: tmp)
    XCTAssertEqual(SwiftFile.exists(path: tmp), false)
  }
  
  func testItWritesAFile() {
    let tmp = SwiftPath.tempFileName(name: "abc.txt")
    
    let r = SwiftFile.write(path: tmp, string: "ABCDEF")
    XCTAssertEqual(r, true)
    
    XCTAssertEqual(SwiftFile.exists(path: tmp), true)
    
    SwiftFile.delete(string: tmp)
  }
  
  func testItReadsAFile() {
    let tmp = SwiftPath.tempFile
    
    SwiftFile.write(path: tmp, string: "TESTTEST")
    let r = SwiftFile.read(path: tmp)
    
    XCTAssertEqual(r, "TESTTEST")
    
    SwiftFile.delete(string: tmp)
  }
  
  func testItWritesAFileString() {
    let tmp = SwiftPath.tempFileName(name: "abc.txt")
    
    let r = "AAAAA".write(toFile: tmp) 
    XCTAssertEqual(r, true)
    
    XCTAssertEqual(SwiftFile.exists(path: tmp), true)
    
    SwiftFile.delete(string: tmp)
  }
  
  func testItReadsAFileString() {
    let tmp = SwiftPath.tempFile
    
    SwiftFile.write(path: tmp, string: "TESTTEST1")
    let r = String.read(contentsOfFile: tmp)
    
    XCTAssertEqual(r, "TESTTEST1")
    
    SwiftFile.delete(string: tmp)
  }
}
