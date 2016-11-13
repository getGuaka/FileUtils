//
//  DirectoryTests.swift
//  FileSystem
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import XCTest
@testable import FileSystem

class DirectoryTests: XCTestCase {

  func testItCreatesADirectory() {
    let tmp = Path.tempFolder
    defer { Directory.delete(path: tmp + "abcdefg") }
    XCTAssertFalse(Path.exists(path: tmp + "abcdefg"))
    
    let res = Directory.create(path: tmp + "abcdefg")
    XCTAssertTrue(res)
    XCTAssertTrue(Path.exists(path: tmp + "abcdefg"))
  }

  func testItDeletesADirectory() {
    let tmp = Path.tempFolder
    XCTAssertFalse(Path.exists(path: tmp + "abcdefg"))

    Directory.create(path: tmp + "abcdefg")
    XCTAssertTrue(Path.exists(path: tmp + "abcdefg"))

    let deleted = Directory.delete(path: tmp + "abcdefg")
    XCTAssertTrue(deleted)
    XCTAssertFalse(Path.exists(path: tmp + "abcdefg"))
  }

  func testItGetsContentOfDirectory() {
    let tmp = Path.tempFolder
    Directory.create(path: tmp + "testing")
    Directory.create(path: tmp + "testing/d1")
    Directory.create(path: tmp + "testing/d2")
    File.create(path: tmp + "testing/f1")
    File.create(path: tmp + "testing/f2")

    defer {
      Directory.delete(path: tmp + "testing")
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
