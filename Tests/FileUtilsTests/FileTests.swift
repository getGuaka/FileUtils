//
//  FileTests.swift
//  FileUtils
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import XCTest
@testable import FileUtils

class FileTests: XCTestCase {

  func testsFileExistsCreateAndDelete() {
    let tmp = Path.tempFile
    XCTAssertEqual(File.exists(tmp), false)

    _ = File(path: tmp, fileMode: .write)
    XCTAssertEqual(File.exists(tmp), true)

    File.delete(atPath: tmp)
    XCTAssertEqual(File.exists(tmp), false)
  }

  func testsFileExistsCreateAndDelete1() {
    let tmp = Path.tempFile
    XCTAssertEqual(File.exists(tmp), false)
    _ = File.create(atPath: tmp)
    XCTAssertEqual(File.exists(tmp), true)

    File.delete(atPath: tmp)
    XCTAssertEqual(File.exists(tmp), false)
  }

  func testItWritesAFile() {
    let tmp = Path.tempFileName(withName: "abc.txt")

    let r = try! File.write(string: "ABCDEF", toPath: tmp)
    XCTAssertEqual(r, true)

    XCTAssertEqual(File.exists(tmp), true)

    File.delete(atPath: tmp)
  }

  func testItReadsAFile() {
    let tmp = Path.tempFile

    try! File.write(string: "TESTTEST", toPath: tmp)
    let r = try! File.read(atPath: tmp)

    XCTAssertEqual(r, "TESTTEST")

    File.delete(atPath: tmp)
  }

  func testItReadANonExistingFile() {
    do {
      _ = try File.read(atPath: "asdsadsda")
      XCTFail()
    } catch FileError.fileNotFound {
    } catch {
      XCTFail()
    }
  }

  func testItReadAAnEmptyFile() {
    let tmp = Path.tempFileName(withName: "empty-file.txt")
    defer { File.delete(atPath: tmp) }

    try! "".write(toFile: tmp)
    let f = try! File.read(atPath: tmp)
    XCTAssertEqual(f, "")
  }

  func testItWritesANonExistingFile() {
    do {
      _ = try File.write(string: "ddd", toPath: "a/b/c/d/e/g/adasdw")
      XCTFail()
    } catch FileError.fileNotFound {
    } catch {
      XCTFail()
    }
  }

  func testItWritesAFileString() {
    let tmp = Path.tempFileName(withName: "abc.txt")

    let r = try! "AAAAA".write(toFile: tmp)
    XCTAssertEqual(r, true)

    XCTAssertEqual(File.exists(tmp), true)

    File.delete(atPath: tmp)
  }

  func testItReadsAFileString() {
    let tmp = Path.tempFile

    try! File.write(string: "TESTTEST1", toPath: tmp)
    let r = try! String.read(contentsOfFile: tmp)

    XCTAssertEqual(r, "TESTTEST1")

    File.delete(atPath: tmp)
  }

  func testItDoesNotCrashIfDeleteANonExistaingFile() {
    let b = File.delete(atPath: "asdsad.w")
    XCTAssertFalse(b)
  }

  static var allTests: [(String, (FileTests) -> () throws -> Void)] {
    return [
      ("testsFileExistsCreateAndDelete", testsFileExistsCreateAndDelete),
      ("testsFileExistsCreateAndDelete1", testsFileExistsCreateAndDelete1),
      ("testItWritesAFile", testItWritesAFile),
      ("testItReadsAFile", testItReadsAFile),
      ("testItReadAAnEmptyFile)", testItReadAAnEmptyFile),
      ("testItWritesAFileString", testItWritesAFileString),
      ("testItReadsAFileString", testItReadsAFileString),
      ("testItDoesNotCrashIfDeleteANonExistaingFile", testItDoesNotCrashIfDeleteANonExistaingFile),

      // Fails on ubuntu, cannot test throw!
      //      ("testItReadANonExistingFile", testItReadANonExistingFile),
      //      ("testItWritesANonExistingFile", testItWritesANonExistingFile),
    ]
  }
}
