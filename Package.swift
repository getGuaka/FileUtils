// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "FileUtils",
    products: [
        .library(name: "FileUtils", targets: ["FileUtils"])
    ],
    targets: [
        .target(
            name: "FileUtils"
        ),

        .testTarget(
            name: "FileUtilsTests",
            dependencies: [
                "FileUtils"
            ]
        )
    ],
    swiftLanguageVersions: [4]
)
