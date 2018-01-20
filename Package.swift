import PackageDescription

#if os(OSX)
let package = Package(
    name: "Pjango",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 3, minor: 0),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 3, minor: 0),
        .Package(url: "https://github.com/enums/SwiftyJSON.git", majorVersion: 4),
        ]
)
#else
let package = Package(
    name: "Pjango",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/enums/SwiftyJSON.git", majorVersion: 4),
        ]
)
#endif


