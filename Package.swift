// swift-tools-version: 5.9
// Package.swift — KyvshieldLiteExample
//
// To use in Xcode:
//   File > Add Package Dependencies… > Add Local…
//   Select: ../../KyvshieldLite/

import PackageDescription

let package = Package(
    name: "KyvshieldLiteExample",
    platforms: [.iOS(.v16)],
    dependencies: [
        // Local dependency (for development)
        // .package(path: "../KyvshieldLite"),

        // Remote SDK from GitHub
        .package(url: "https://github.com/moussa-innolink/kyv_swift.git", exact: "0.0.4"),
    ],
    targets: [
        .executableTarget(
            name: "KyvshieldLiteExample",
            dependencies: [
                // Local dependency (for development)
                // .product(name: "KyvshieldLite", package: "KyvshieldLite"),

                // Remote SDK from GitHub
                .product(name: "KyvshieldLite", package: "kyv_swift"),
            ],
            path: "KyvshieldLiteExample"
        ),
    ]
)
