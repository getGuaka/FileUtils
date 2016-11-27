//
//  StringExtensions.swift
//  SwiftFile
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import Foundation

extension String {
  
  public static func read(contentsOfFile file: String) throws -> String {
    return try File.read(atPath: file)
  }

  @discardableResult
  public func write(toFile file: String) throws -> Bool {
    return try File.write(string: self, toPath: file)
  }
}
