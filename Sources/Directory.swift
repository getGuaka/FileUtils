//
//  Directory.swift
//  SwiftFile
//
//  Created by Omar Abdelhafith on 12/11/2016.
//
//

#if os(Linux)
  @_exported import Glibc
#else
  @_exported import Darwin.C
#endif

import Foundation


/// Directory related functions
public enum Directory {

  /// Create a directory at a location
  ///
  /// - parameter path: the directory location
  ///
  /// - returns: true if succeeds, otherwise false
  @discardableResult
  public static func create(path: String) -> Bool {
    return mkdir(path, S_IRWXU | S_IRWXG | S_IRWXO) == 0
  }

  /// Deletes a directory at a path
  ///
  /// - parameter path: the directory location
  ///
  /// - returns: true if succeeds, otherwise false
  @discardableResult
  public static func delete(path: String) -> Bool {
    return rmdir(path) == 0
  }

  /// Gets the contents of a directory
  ///
  /// - parameter directory: the directory to gets content of
  ///
  /// - returns: a tuple containing the files and directories found at the path given
  public static func contents(ofDirectory directory: String)
    -> (files: [String], directories: [String])? {
      guard
        Path.exists(path: directory),
        Path.pathType(path: directory) == .directory else { return nil }

      guard let dir = opendir(directory) else { return nil }
      defer { closedir(dir) }

      var retDirs = [String]()
      var retFiles = [String]()

      while let content = readdir(dir) {
        let name = dirNameToString(dirent: content.pointee)
        if name == "." || name == ".." { continue }

        if Path.pathType(path: "\(directory)/\(name)") == .directory {
          retDirs.append(name)
        } else {
          retFiles.append(name)
        }
      }

      return (files: retFiles, directories: retDirs)
  }

  private static func dirNameToString(dirent: dirent) -> String {
    var mutDirent = dirent
    var name = ""
    withUnsafePointer(to: &mutDirent.d_name) { p in
      // TBD: Cast ptr to (CChar,CChar) tuple to an UnsafePointer<CChar>.
      //      Is this the right way to do it? No idea.
      //      Rather do withMemoryRebound? But what about the capacity?
      let rp  = UnsafeRawPointer(p)
      let crp = rp.assumingMemoryBound(to: CChar.self)
      name       = String(cString: crp) // TBD: rather validatingUTF8?
    }

    return name
  }

}
