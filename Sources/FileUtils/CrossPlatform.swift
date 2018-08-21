//
//  CrossPlatform.swift
//  FileUtils
//
//  Created by Omar Abdelhafith on 10/01/2017.
//
//

#if os(Linux)
  @_exported import Glibc
#else
  @_exported import Darwin.C
#endif

func get_basename(_ path: String) -> UnsafeMutablePointer<Int8>? {
  #if os(Linux)
    let parts = strrchr(path, Int32("/".utf8CString.first!))
    return parts?.advanced(by: 1)
  #else
    var mutPath: [Int8] = Array(path.utf8CString)
    return basename(&mutPath)
  #endif
}

func getTempDir() -> String {
  guard let path = getenv("TMPDIR") else { return "/tmp/" }

  return String(cString: path)
}
