//
//  Utilities.swift
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


func randomString(length: Int) -> String {

  #if os(Linux)
    srandom(UInt32(time(nil)))
  #endif

  let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  let len = letters.count

  var randomString: [Character] = []

  for _ in 0 ..< length {
    let rand = getRandom(len: len)
    let nextChar = letters[letters.index(letters.startIndex, offsetBy: rand)]

    randomString.append(nextChar)
  }

  return String(randomString)
}

func getRandom(len: Int) -> Int {
  #if os(Linux)
    return Int(rand()) % Int(len)
  #else
    return Int(arc4random() % UInt32(len))
  #endif
}
