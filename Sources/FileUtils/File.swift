//
//  SwiftFile.swift
//  File
//
//  Created by Omar Abdelhafith on 12/11/2016.
//
//

#if os(Linux)
  @_exported import Glibc
#else
  @_exported import Darwin.C
#endif


/// Wraps a file and provide methods to deal with files
public class File {
  
  public typealias FileType = UnsafeMutablePointer<FILE>?
  let fileHandle: FileType

  /// Initialize a file with a path and open mode
  ///
  /// - parameter path:     the file path
  /// - parameter fileMode: the open mode
  ///
  /// - returns: a file class
  public init(path: String, fileMode: OpenMode) {
    self.fileHandle = fopen(path, fileMode.rawValue)
  }

  init(fileHandle: FileType) {
    self.fileHandle = fileHandle
  }
  
  deinit {
    if let fileHandle = self.fileHandle {
	fclose(fileHandle)
    }
  }

  /// Reads the file content and returns a string
  ///
  /// - returns: the textual file content
  public func read() throws -> String {
    guard let fileHandle = fileHandle else { throw FileError.fileNotFound }
    
    fseek(fileHandle, 0, SEEK_END)
    let fileLen = ftell(fileHandle)
    rewind(fileHandle)
    
    guard fileLen > 0 else { return "" }
    
    let mut = UnsafeMutablePointer<UInt8>.allocate(capacity: fileLen + 1)
    fread(mut, 1, fileLen, fileHandle)
    
    let buff = UnsafeMutableBufferPointer(start: mut, count: fileLen + 1)
    buff.baseAddress?[fileLen] = 0
    
    guard let baseAddress = buff.baseAddress else { throw FileError.cantReadFile }

    return String(cString: baseAddress)
  }

  /// Writes a string to the file
  ///
  /// - parameter string: the string to write
  ///
  /// - returns: true if successful, otherwise false
  public func write(string: String) throws -> Bool {
    guard let fileHandle = fileHandle else { throw FileError.fileNotFound }
    
    let cstring = Array(string.utf8)
    let written = fwrite(cstring, cstring.count, 1, fileHandle)
    return written == 1
  }
}


extension File {


  /// Create a new file at the path
  ///
  /// - parameter path: path to create the file at
  ///
  /// - returns: trueif successful, otherwise false
  @discardableResult
  public static func create(atPath path: String) -> Bool {
    return File(path: path, fileMode: .write).fileHandle != nil
  }

  /// Reads the textual content of the file at the location
  ///
  /// - parameter path: the file to read
  ///
  /// - returns: the textual content of the file
  public static func read(atPath path: String) throws -> String {
    return try File(path: path, fileMode: .read).read()
  }

  /// Write a string to the path passed
  ///
  /// - parameter path:   the path to write to
  /// - parameter string: the string to write
  ///
  /// - returns: trueif successful, otherwise false
  @discardableResult
  public static func write(string: String, toPath path: String) throws -> Bool {
    return try File(path: path, fileMode: .write).write(string: string)
  }

  /// deletes a file at a path
  ///
  /// - parameter path: the file path
  ///
  /// - returns: trueif successful, otherwise false
  @discardableResult
  public static func delete(atPath path: String) -> Bool {
    return remove(path) == 0
  }

  /// Checks if file exsist at a path
  ///
  /// - parameter path: the file path
  ///
  /// - returns: trueif exists, otherwise false
  public static func exists(_ path: String) -> Bool {
    return access(path, F_OK) != -1
  }
}


extension File {

  /// File open mode
  ///
  /// - read:      read only
  /// - readWrite: read write
  /// - write:     write, the file will be cleared when openend
  public enum OpenMode: String {
    case read = "r"
    case readWrite = "r+"
    case write = "w"
  }
}
