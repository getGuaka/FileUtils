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
    let tmp = Path.tempPath
    XCTAssertEqual(tmp.contains("/var/folders"), true)
  }

  func testItGetsTempFilePath() {
    let tmp = Path.tempFileName(withName: "abc.txt")
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
    let tmp = Path.tempPath
    defer { Directory.delete(atPath: tmp + "abcdefg") }
    Directory.create(atPath: tmp + "abcdefg")

    let type = Path.type(ofPath: tmp + "abcdefg")
    XCTAssertEqual(type, PathType.directory)
  }

  func testItGetsFilePathType() {
    let tmp = Path.tempPath
    defer { File.delete(atPath: tmp + "abcdefg") }
    File.create(atPath: tmp + "abcdefg")

    let type = Path.type(ofPath: tmp + "abcdefg")
    XCTAssertEqual(type, PathType.file)
  }

  func testItExpandsAPath() {
    let tmp = Path.expand("~/Documents")

    XCTAssertEqual(tmp.contains("/Users"), true)
  }

  func testItExpandsAPathHandlesErrors() {
    let tmp = Path.expand("/Documents")

    XCTAssertEqual(tmp.contains("/Documents"), true)
  }

  func testItGetsTheDirName() {
    let path = Path.dirName(forPath: "/Documents/a/b/c/d")

    XCTAssertEqual(path, "/Documents/a/b/c")
  }

  func testItGetsTheBaseName() {
    let path = Path.baseName(forPath: "/Documents/a/b/c/d")

    XCTAssertEqual(path, "d")
  }

  func testItHandlesBadPaths() {
    let path = Path.baseName(forPath: "abcd")

    XCTAssertEqual(path, "abcd")
  }

  func testItCanSetTheWorkingDirectory() {
    let c = Path.currentDirectory
    let new = Path.expand("~")

    Path.currentDirectory = Path.expand("~")
    XCTAssertEqual(Path.currentDirectory, new)
    XCTAssertNotEqual(Path.currentDirectory, c)
  }

  func testItExpandsAGlob() {
    let tmp = Path.expand(Path.tempPath)
    Path.currentDirectory = tmp + "testing"

    var root = Path.currentDirectory

    Directory.create(atPath: root)
    Directory.create(atPath: root + "/d1")
    Directory.create(atPath: root + "/d2")
    File.create(atPath: root + "/f1")
    File.create(atPath: root + "/f2")

    defer {
      Directory.delete(atPath: root)
    }


    let files = Path.files(matchingGlobPattern: "f*")

    XCTAssertEqual(files.contains("f1"), true)
    XCTAssertEqual(files.contains("f2"), true)

    let dirs = Path.files(matchingGlobPattern: "d*")

    XCTAssertEqual(dirs.contains("d1"), true)
    XCTAssertEqual(dirs.contains("d2"), true)
  }

}
