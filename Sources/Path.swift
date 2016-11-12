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

public enum Path {
  
  public static var tempFolder: String {
    guard let path = getenv("TMPDIR") else { return "" }
    
    return String(cString: path)
  }
  
  public static var tempFile: String {
    return tempFileName(name: randomString(length: 10))
  }
  
  public static func tempFileName(name: String) -> String {
    guard let path = getenv("TMPDIR") else { return "" }
    
    return String(cString: path) + name
  }
  
}



func randomString(length: Int) -> String {
  
  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  let len = letters.characters.count
  
  var randomString: [Character] = [] 
  
  for _ in 0 ..< length {
    let rand = Int(arc4random_uniform(UInt32(len)))
    let nextChar = letters.characters[letters.index(letters.startIndex, offsetBy: rand)]
    
    randomString.append(nextChar)
  }
  
  return String(randomString)
}
