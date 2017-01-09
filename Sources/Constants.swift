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
    if S_IFDIR == stat.st_mode || 16877 == stat.st_mode {
      self = .directory
    } else if S_IEXEC == stat.st_mode {
      self = .directory
    } else if S_IFLNK == stat.st_mode {
      self = .link
    } else {
      self = .file
    }
  }
}
