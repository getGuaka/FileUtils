//
//  FileTests.swift
//  FileSystem
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import XCTest
@testable import FileSystem

class FileTests: XCTestCase {
  
  func testsFileExistsCreateAndDelete() {
    let tmp = Path.tempFile
    XCTAssertEqual(File.exists(path: tmp), false)
    _ = File(path: tmp, fileMode: .write)
    XCTAssertEqual(File.exists(path: tmp), true)

    File.delete(path: tmp)
    XCTAssertEqual(File.exists(path: tmp), false)
  }

  func testsFileExistsCreateAndDelete1() {
    let tmp = Path.tempFile
    XCTAssertEqual(File.exists(path: tmp), false)
    _ = File.create(path: tmp)
    XCTAssertEqual(File.exists(path: tmp), true)

    File.delete(path: tmp)
    XCTAssertEqual(File.exists(path: tmp), false)
  }

  func testItWritesAFile() {
    let tmp = Path.tempFileName(name: "abc.txt")

    let r = try! File.write(path: tmp, string: "ABCDEF")
    XCTAssertEqual(r, true)

    XCTAssertEqual(File.exists(path: tmp), true)

    File.delete(path: tmp)
  }

  func testItReadsAFile() {
    let tmp = Path.tempFile

    try! File.write(path: tmp, string: "TESTTEST")
    let r = try! File.read(path: tmp)

    XCTAssertEqual(r, "TESTTEST")

    File.delete(path: tmp)
  }

  func testItReadANonExistingFile() {
    do {
      _ = try File.read(path: "asdsadsda")
      XCTFail()
    } catch FileError.fileNotFound {
    } catch {
      XCTFail()
    }
  }

  func testItReadAAnEmptyFile() {
    let tmp = Path.tempFileName(name: "empty-file.txt")
    defer { File.delete(path: tmp) }

    try! "".write(toFile: tmp)
    let f = try! File.read(path: tmp)
    XCTAssertEqual(f, "")
  }

  func testItWritesANonExistingFile() {
    do {
      _ = try File.write(path: "a/b/c/d/e/g/adasdw", string: "ddd")
      XCTFail()
    } catch FileError.fileNotFound {
    } catch {
      XCTFail()
    }
  }

  func testItWritesAFileString() {
    let tmp = Path.tempFileName(name: "abc.txt")

    let r = try! "AAAAA".write(toFile: tmp)
    XCTAssertEqual(r, true)

    XCTAssertEqual(File.exists(path: tmp), true)

    File.delete(path: tmp)
  }

  func testItReadsAFileString() {
    let tmp = Path.tempFile

    try! File.write(path: tmp, string: "TESTTEST1")
    let r = try! String.read(contentsOfFile: tmp)

    XCTAssertEqual(r, "TESTTEST1")

    File.delete(path: tmp)
  }

  func testItDoesNotCrashIfDeleteANonExistaingFile() {
    let b = File.delete(path: "asdsad.w")
    XCTAssertFalse(b)
  }
}
