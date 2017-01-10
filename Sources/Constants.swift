//
//  Constants.swift
//  FileUtils
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

#if os(Linux)
  @_exported import Glibc
#else
  @_exported import Darwin.C
#endif



/// File error type
///
/// - fileNotFound: File is not found
/// - fileEmpty:    File is empty
/// - cantReadFile: Cannot read file
public enum FileError: Error {
  case fileNotFound
  case fileEmpty
  case cantReadFile
}


/// Path type
///
/// - directory:  path is directory
/// - executable: path is executable
/// - link:       path is a link
/// - file:       path is a file
public enum PathType {
  case directory
  case executable
  case link
  case file

  init(stat: stat) {
    self = .directory

    if stat.isDirectory {
      self = .directory
    } else if stat.isExecutable {
      self = .directory
    } else if stat.isLink {
      self = .link
    } else {
      self = .file
    }

  }
}

extension stat {

  fileprivate var isExecutable: Bool {
    #if os(Linux)
      return UInt32(S_IEXEC) == st_mode
      #else
      return S_IEXEC == st_mode
    #endif
  }

  fileprivate var isLink: Bool {
    return S_IFLNK == st_mode
  }

  fileprivate var isDirectory: Bool {
    return S_IFDIR == st_mode || 16877 == st_mode || 16893 == st_mode
  }
}
