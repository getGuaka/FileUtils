//
//  StringExtensions.swift
//  SwiftFile
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import Foundation

extension String {
  
  public static func read(contentsOfFile file: String) throws -> String? {
    return try File.read(path: file)
  }

  @discardableResult
  public func write(toFile file: String) throws -> Bool {
    return try File.write(path: file, string: self)
  }
}
