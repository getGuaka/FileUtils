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

  /// Gets the path of the system temp directory
  public static var tempPath: String {
    return getTempDir()
  }

  /// Gets the path of a temp file
  public static var tempFile: String {
    return tempFileName(withName: randomString(length: 10))
  }

  /// Gets the path of a temp file
  ///
  /// - parameter name: the file name
  ///
  /// - returns: the path of a temp file
  public static func tempFileName(withName name: String) -> String {
    let tempDir = getTempDir()

    return tempDir + name
  }


  /// Gets the current directory
  public static var currentDirectory: String {
    get {
      var arr: [Int8] = Array(repeating: 0, count: 1024)
      guard let curr = getcwd(&arr, 1024) else { return "" }

      return String(cString: curr)
    }
    set {
      chdir(newValue)
    }
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
  public static func exists(_ path: String) -> Bool {
    return File.exists(path)
  }

  /// Checks if path exists
  ///
  /// - parameter name: the path
  ///
  /// - returns: true if path exists, otherwise false
  public static func type(ofPath path: String) -> PathType {
    var res: stat = stat()
    stat(path, &res)

    return PathType(stat: res)
  }

  /// Return the base name for the path passed by returning the last segment of the path
  ///
  /// - parameter path: the path passed
  ///
  /// - returns: the base name of the path
  public static func baseName(forPath path: String) -> String {
    guard let ret = get_basename(path) else { return path }

    return String(cString: ret)
  }

  /// Returns the directory name for the path passed by removing the first segment of the path..
  ///
  /// - parameter path: the path passed
  ///
  /// - returns: the directory name of the path
  public static func dirName(forPath path: String) -> String {
    var mutPath: [Int8] = Array(path.utf8CString)
    guard let ret = dirname(&mutPath) else { return path }

    return String(cString: ret)
  }

  /// Expand the path if contains ~
  ///
  /// - parameter path: the path to expand
  ///
  /// - returns: the expanded path
  public static func expand(_ path: String) -> String {
    var wordExp = wordexp_t()
    wordexp(path, &wordExp, 0)

    guard let expanded = wordExp.we_wordv[0] else { return path }
    return String(cString: expanded)
  }

  /// Get the files and directories that match the passed glob pattern
  ///
  /// - parameter pattern: the pattern to expand
  ///
  /// - returns: a list of files and directories that match the passed glob
  public static func files(matchingGlobPattern pattern: String) -> [String] {
    var files = [String]()
    var gt: glob_t = glob_t()
    defer { globfree(&gt) }

    if (glob(pattern, 0, nil, &gt) == 0) {
      for i in (0..<gt.gl_pathc) {
        let x = gt.gl_pathv[Int(i)]
        let c = UnsafePointer<CChar>(x)!
        let s = String.init(cString: c)
        files.append(s)
      }
    }
    
    return files
  }
}
