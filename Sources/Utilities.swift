//
//  Utilities.swift
//  FileSystem
//
//  Created by Omar Abdelhafith on 13/11/2016.
//
//

import Foundation


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
