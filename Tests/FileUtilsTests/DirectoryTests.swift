//
//  DirectoryTests.swift
//  FileUtils
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import XCTest
@testable import FileUtils

class DirectoryTests: XCTestCase {

  func testItCreatesADirectory() {
    let tmp = Path.tempPath
    defer { Directory.delete(atPath: tmp + "abcdefg") }
    XCTAssertFalse(Path.exists(tmp + "abcdefg"))
    
    let res = Directory.create(atPath: tmp + "abcdefg")
    XCTAssertTrue(res)
    XCTAssertTrue(Path.exists(tmp + "abcdefg"))
  }

  func testItDeletesADirectory() {
    let tmp = Path.tempPath
    XCTAssertFalse(Path.exists(tmp + "abcdefg"))

    Directory.create(atPath: tmp + "abcdefg")
    XCTAssertTrue(Path.exists(tmp + "abcdefg"))

    let deleted = Directory.delete(atPath: tmp + "abcdefg")
    XCTAssertTrue(deleted)
    XCTAssertFalse(Path.exists(tmp + "abcdefg"))
  }

  func testItGetsContentOfDirectory() {
    let tmp = Path.tempPath
    Directory.create(atPath: tmp + "testing")
    Directory.create(atPath: tmp + "testing/d1")
    Directory.create(atPath: tmp + "testing/d2")
    File.create(atPath: tmp + "testing/f1")
    File.create(atPath: tmp + "testing/f2")

    defer {
      Directory.delete(atPath: tmp + "testing")
    }

    let (files, directories) = Directory.contents(ofDirectory: tmp + "testing")!
    XCTAssertEqual(files.contains("f1"), true)
    XCTAssertEqual(files.contains("f2"), true)
    XCTAssertEqual(directories.contains("d1"), true)
    XCTAssertEqual(directories.contains("d2"), true)
  }

  func testItHandlesErrorWhenGettingContentOfDir() {
    let res = Directory.contents(ofDirectory: "1testing")
    XCTAssertNil(res)
  }

}
