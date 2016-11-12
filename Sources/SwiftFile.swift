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



public class SwiftFile {
  
  public typealias FileType = UnsafeMutablePointer<FILE>?
  let fileHandle: FileType
  
  public init(path: String, fileMode: OpenMode) {
    self.fileHandle = fopen(path, fileMode.rawValue)
  }
  
  public init(fileHandle: FileType) {
    self.fileHandle = fileHandle
  }
  
  deinit {
    fclose(fileHandle)
  }

  public func read() -> String? {
    guard let fileHandle = fileHandle else { return nil }
    
    fseek(fileHandle, 0, SEEK_END)
    let fileLen = ftell(fileHandle)
    rewind(fileHandle)
    
    guard fileLen > 0 else { return nil }
    
    let mut = UnsafeMutablePointer<UInt8>.allocate(capacity: fileLen)
    fread(mut, 1, fileLen, fileHandle)
    
    let buff = UnsafeMutableBufferPointer(start: mut, count: fileLen + 1)
    buff.baseAddress?[fileLen] = 0
    
    if let baseAddress = buff.baseAddress {
      return String(cString: baseAddress)  
    }
    
    return nil
  }
  
  public func write(string: String) -> Bool {
    guard let fileHandle = fileHandle else { return false }
    
    let cstring = Array(string.utf8)
    let written = fwrite(cstring, cstring.count, 1, fileHandle)
    return written == 1
  }
}


extension SwiftFile {
  
  @discardableResult
  public static func create(path: String) -> Bool {
    return SwiftFile(path: path, fileMode: .write).fileHandle != nil
  }  
  
  public static func read(path: String) -> String? {
    let fp = SwiftFile(path: path, fileMode: .read)
    return fp.read()
  }
  
  @discardableResult
  public static func write(path: String, string: String) -> Bool {
    return SwiftFile(path: path, fileMode: .write).write(string: string)
  }
  
  @discardableResult
  public static func delete(string: String) -> Bool {
    return remove(string) == 0
  }
  
  public static func exists(path: String) -> Bool {
    return access(path, F_OK) != -1
  }
}


extension SwiftFile {
  public enum OpenMode: String {
    case read = "r"
    case readWrite = "r+"
    case write = "w"
  }
}

extension String {
  public static func read(contentsOfFile file: String) -> String? {
    return SwiftFile.read(path: file)
  }
  
  public func write(toFile file: String) -> Bool {
    return SwiftFile.write(path: file, string: self)
  }
}
