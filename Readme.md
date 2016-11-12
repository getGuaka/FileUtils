# File

[![Build Status](https://travis-ci.org/oarrabi/File.svg?branch=master)](https://travis-ci.org/oarrabi/File)
[![codecov](https://codecov.io/gh/oarrabi/File/branch/master/graph/badge.svg)](https://codecov.io/gh/oarrabi/File)
[![Platform](https://img.shields.io/badge/platform-osx-lightgrey.svg)](https://travis-ci.org/oarrabi/File)
[![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)](https://travis-ci.org/oarrabi/File)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Easy way to work with files in swift on macOS and linux.

## Why?

You are developing a cli and you want to:
- Read/Write files
- Create/Delete files
- Get temporary files

Todo:
- Handle non textual files contents
- Rename/Move files
- Dealing with directories
- Dealing with globs

This library only deals with textual files contents.

## Usage

Create a files

```swift
```

Delte a file

Read file content

Write file content

Get temporary file and directory


## Installation
You can install File using Swift package manager (SPM) and carthage

### Swift Package Manager
Add File as dependency in your `Package.swift`

```
  import PackageDescription

  let package = Package(name: "YourPackage",
    dependencies: [
      .Package(url: "https://github.com/oarrabi/File.git", majorVersion: 0),
    ]
  )
```

### Carthage
    github 'oarrabi/File'

## Tests
Tests can be found [here](https://github.com/oarrabi/File/tree/master/Tests).

Run them with
```
swift test
```

## Contributing

Just send a PR! We don't bite ;)
