import XCTest
@testable import File

class FileTests: XCTestCase {
  
  func testItGetsTempPath() {
    let tmp = Path.tempFolder
      XCTAssertEqual(tmp.contains("/var/folders"), true)
  }
  
  func testItGetsTempFilePath() {
    let tmp = Path.tempFileName(name: "abc.txt")
    XCTAssertEqual(tmp.contains("/var/folders"), true)
    XCTAssertEqual(tmp.contains("abc.txt"), true)
  }
  
  func testItGetsRandomTempFilePath() {
    let tmp = Path.tempFile
    XCTAssertEqual(tmp.contains("/var/folders"), true)
  }
  
  func testsFileExistsCreateAndDelete() {
    let tmp = Path.tempFile
    XCTAssertEqual(File.exists(path: tmp), false)
    _ = File(path: tmp, fileMode: .write)
    XCTAssertEqual(File.exists(path: tmp), true)
    
    File.delete(string: tmp)
    XCTAssertEqual(File.exists(path: tmp), false)
  }
  
  func testItWritesAFile() {
    let tmp = Path.tempFileName(name: "abc.txt")
    
    let r = File.write(path: tmp, string: "ABCDEF")
    XCTAssertEqual(r, true)
    
    XCTAssertEqual(File.exists(path: tmp), true)
    
    File.delete(string: tmp)
  }
  
  func testItReadsAFile() {
    let tmp = Path.tempFile
    
    File.write(path: tmp, string: "TESTTEST")
    let r = File.read(path: tmp)
    
    XCTAssertEqual(r, "TESTTEST")
    
    File.delete(string: tmp)
  }
  
  func testItWritesAFileString() {
    let tmp = Path.tempFileName(name: "abc.txt")
    
    let r = "AAAAA".write(toFile: tmp) 
    XCTAssertEqual(r, true)
    
    XCTAssertEqual(File.exists(path: tmp), true)
    
    File.delete(string: tmp)
  }
  
  func testItReadsAFileString() {
    let tmp = Path.tempFile
    
    File.write(path: tmp, string: "TESTTEST1")
    let r = String.read(contentsOfFile: tmp)
    
    XCTAssertEqual(r, "TESTTEST1")
    
    File.delete(string: tmp)
  }

  
  
//    func testItCreatesAFile() {
//      let r = File.create(path: "abcde.txt")
//      XCTAssertEqual(r, true)
//    }
}
