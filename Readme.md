# FileUtils

[![Build Status](https://travis-ci.org/oarrabi/FileUtils.svg?branch=master)](https://travis-ci.org/oarrabi/FileUtils)
[![codecov](https://codecov.io/gh/oarrabi/FileUtils/branch/master/graph/badge.svg)](https://codecov.io/gh/oarrabi/FileUtils)
[![Platform](https://img.shields.io/badge/platform-osx-lightgrey.svg)](https://travis-ci.org/oarrabi/FileUtils)
[![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)](https://travis-ci.org/oarrabi/FileUtils)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Easy way to work with files, directories and paths in swift on macOS and linux.

## Why?

You are developing a cli and you want to:
- Read/Write files.
- Create/Delete files.
- Create/Delete/List directories.
- Get different paths (Home/Current/Temp).
- Get the base name and directory name of a path


You can use `FileUtils` with [Guaka](https://github.com/oarrabi/Process) to create aweseome command line applications.

Note: At the moment, this library only deals with textual files contents. (Check todo section of this file).

## Usage

### File
Create a file

```swift
File(path: path, fileMode: .write)

//OR
File.create(path: path)
```

Delete a file

```swift
File.delete(atPath: path)
```

Read file content

```swift
let content = File.read(atPath: path)

// or
let content = String.read(contentsOfFile: path)
```

Write file content

```swift
File.write(string: "ABCDEF", toPath: path, )

// or
"AAAAA".write(toFile: path)
```

Check if file exists

```swift
File.exists(path)
```

### Path

Get temporary file and directory

```swift
let tmp = Path.tempPath

// or
let tmp = Path.tempFile

// or
let tmp = Path.tempFileName(withName: "abc.txt")
```

Get the current directory

```swift
let path = Path.currentDirectory
```

Get the home directory

```swift
let path = Path.home
```

Check if the path exists

```swift
let exists = Path.exists(path)
```

Check the type of the file at a path

```swift
let type = Path.type(ofPath: path)
```

type is a member of the `PathType` enum. This enum defines `directory`, `executable`, `link` and `file`

Expand a tilde in the path

```swift
let expanded = Path.expand("~/Documents")
// expanded is "/Users/YourUser/Documents"
```

Get the base name and the directory name of a path

```swift
let base = Path.baseName(forPath: "/Documents/this/is/mypath")
// base is "mypath"

let dir = Path.dirName(forPath: "/Documents/this/is/mypath")
// dir is "/Documents/this/is"
```

### Directory

Create a directory

```swift
Directory.create(atPath: path)
```

Delete a directory

```swift
Directory.delete(atPath: path)
```

Enumerate contents of a directory

```swift
let (files, directories) = Directory.contents(ofDirectory: path)!
```

this returns a tuple that contains all the files and directories found at the path

## Installation
You can install File using Swift package manager (SPM) and Carthage

### Swift Package Manager
Add FileSystem as a dependency in your `Package.swift`

```
  import PackageDescription

  let package = Package(name: "YourPackage",
    dependencies: [
      .Package(url: "https://github.com/oarrabi/FileUtils.git", majorVersion: 0),
    ]
  )
```

### Carthage
    github 'oarrabi/FileUtils'

## Tests
Tests can be found [here](https://github.com/oarrabi/FileUtils/tree/master/Tests).

Run them with
```
swift test
```

## Todo
- Handle non textual files contents

## Contributing

Just send a PR! We don't bite ;)
