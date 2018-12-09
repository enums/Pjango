// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pjango",
    products: [
        .library(
            name: "Pjango",
            targets: ["Pjango"]),
        ],
    dependencies: [
        .package(url:"https://github.com/PerfectlySoft/Perfect-HTTPServer.git" , from: "3.0.19"),
        .package(url:"https://github.com/PerfectlySoft/Perfect-Mustache.git" , from: "3.0.2"),
        .package(url:"https://github.com/enums/Pjango-SwiftyJSON" , from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Pjango",
            dependencies: ["PerfectHTTPServer", "PerfectMustache", "SwiftyJSON"])
    ]
)


