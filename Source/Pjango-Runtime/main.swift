//
//  run.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import Pjango_Demo
import Pjango_Core

// MARK: - Prepare
let log = CommandLineLog.init(tag: "Pjango-Runtime")
log.info("Hello Pjango!")

// MARK: - CommandLine
guard CommandLine.argc >= 2 else {
    log.error("Please input port!")
    exit(0)
}

guard let port = UInt16(CommandLine.arguments[1]) else {
    log.error("Illegal port!")
    exit(0)
}

// MARK: - Init
log.info("Initializing...")
settings_build()

// MARK: - Configuration
log.info("Configuring...")
var urls_urlToConfig = Dictionary<String, PCUrlConfig>()
var urls_nameToConfig = Dictionary<String, PCUrlConfig>()

urlpatterns.forEach { config in
    urls_urlToConfig[config.url] = config
    if let name = config.name {
        urls_nameToConfig[name] = config
    }
}


var routes = Routes.init()

urls_urlToConfig.forEach { (url, config) in
    routes.add(uri: url, handler: config.handle)
}

// MARK: - Server
log.info("Starting...")
let server = HTTPServer.init()
server.documentRoot = static_url
server.serverPort = port
server.addRoutes(routes)
do {
    try server.start()
} catch {
    log.error(error)
}

