//
//  Path.swift
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


/// Provide easy eaccess to system pathds
public enum Path {

  /// Gets the location of the temp folder
  public static var tempFolder: String {
    guard let path = getenv("TMPDIR") else { return "" }
    
    return String(cString: path)
  }

  /// Gets the location of a temp file
  public static var tempFile: String {
    return tempFileName(name: randomString(length: 10))
  }

  /// Gets the location of a temp file
  ///
  /// - parameter name: the file name
  ///
  /// - returns: the path of a temp file
  public static func tempFileName(name: String) -> String {
    guard let path = getenv("TMPDIR") else { return "" }
    
    return String(cString: path) + name
  }

  /// Gets the current directory
  public static var currentDirectory: String {
    var arr: [Int8] = Array(repeating: 0, count: 1024)
    guard let curr = getcwd(&arr, 1024) else { return "" }

    return String(cString: curr)
  }

  /// Gets the current directory
  public static var home: String {
    guard let path = getenv("HOME") else { return "" }

    return String(cString: path)
  }

  /// Checks if path exists
  ///
  /// - parameter name: the path
  ///
  /// - returns: true if path exists, otherwise false
  public static func exists(path: String) -> Bool {
    return File.exists(path: path)
  }

  /// Checks if path exists
  ///
  /// - parameter name: the path
  ///
  /// - returns: true if path exists, otherwise false
  public static func pathType(path: String) -> PathType {
    var res: stat = stat()
    stat(path, &res)

    return PathType(stat: res)
  }

  /// Return the base name for the path passed by returning the last segment of the path
  ///
  /// - parameter path: the path passed
  ///
  /// - returns: the base name of the path
  public static func baseName(path: String) -> String {
    var mutPath: [Int8] = Array(path.utf8CString)
    guard let ret = basename(&mutPath) else { return path }

    return String(cString: ret)
  }

  /// Returns the directory name for the path passed by removing the first segment of the path..
  ///
  /// - parameter path: the path passed
  ///
  /// - returns: the directory name of the path
  public static func dirName(path: String) -> String {
    var mutPath: [Int8] = Array(path.utf8CString)
    guard let ret = dirname(&mutPath) else { return path }

    return String(cString: ret)
  }

  /// Expand the path if contains ~
  ///
  /// - parameter path: the path to expand
  ///
  /// - returns: the expanded path
  public static func expand(path: String) -> String {
    var wordExp = wordexp_t()
    wordexp(path, &wordExp, 0)

    guard let expanded = wordExp.we_wordv[0] else { return path }
    return String(cString: expanded)
  }

}
