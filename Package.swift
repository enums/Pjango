import PackageDescription

let package = Package(
    name: "Pjango",
    targets: [
        Target(name: "Pjango-Demo", dependencies:["Pjango-Core"]),
        Target(name: "Pjango-Runtime", dependencies:["Pjango-Core", "Pjango-Demo"])
    ],
    dependencies: [
        .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion: 3),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-CURL.git", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),
    ]
)
