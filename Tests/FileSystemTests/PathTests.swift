//
//  PathTests.swift
//  FileSystem
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import XCTest
@testable import FileSystem

class PathTests: XCTestCase {

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

  func testItGetsCurrentDirectory() {
    let tmp = Path.currentDirectory
    XCTAssertEqual(tmp.characters.count > 0, true)
  }

  func testItGetsHomeDirectory() {
    let tmp = Path.home
    XCTAssertEqual(tmp.contains("/Users"), true)
  }

  func testItGetsDirPathType() {
    let tmp = Path.tempFolder
    defer { Directory.delete(path: tmp + "abcdefg") }
    Directory.create(path: tmp + "abcdefg")

    let type = Path.pathType(path: tmp + "abcdefg")
    XCTAssertEqual(type, PathType.directory)
  }

  func testItGetsFilePathType() {
    let tmp = Path.tempFolder
    defer { File.delete(path: tmp + "abcdefg") }
    File.create(path: tmp + "abcdefg")

    let type = Path.pathType(path: tmp + "abcdefg")
    XCTAssertEqual(type, PathType.file)
  }

  func testItExpandsAPath() {
    let tmp = Path.expand(path: "~/Documents")

    XCTAssertEqual(tmp.contains("/Users"), true)
  }

  func testItExpandsAPathHandlesErrors() {
    let tmp = Path.expand(path: "/Documents")

    XCTAssertEqual(tmp.contains("/Documents"), true)
  }

  func testItGetsTheDirName() {
    let path = Path.dirName(path: "/Documents/a/b/c/d")

    XCTAssertEqual(path, "/Documents/a/b/c")
  }

  func testItGetsTheBaseName() {
    let path = Path.baseName(path: "/Documents/a/b/c/d")

    XCTAssertEqual(path, "d")
  }

  func testItHandlesBadPaths() {
    let path = Path.baseName(path: "abcd")

    XCTAssertEqual(path, "abcd")
  }

}
