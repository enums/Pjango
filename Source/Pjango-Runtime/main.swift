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
let _pjango_runtime_log = PCCommandLineLog.init(tag: "Pjango-Runtime")
_pjango_runtime_log.info("Hello Pjango!")

// MARK: - CommandLine
guard CommandLine.argc >= 2 else {
    _pjango_runtime_log.error("Please input port!")
    exit(0)
}

guard let port = UInt16(CommandLine.arguments[1]) else {
    _pjango_runtime_log.error("Illegal port!")
    exit(0)
}

// MARK: - Init
_pjango_runtime_log.info("Initializing...")
_pjango_runtime_build_settings()

// MARK: - Configuration
_pjango_runtime_log.info("Configuring...")
var _pjango_runtime_urls_urlToConfig = Dictionary<String, PCUrlConfig>()
var _pjango_runtime_urls_nameToConfig = Dictionary<String, PCUrlConfig>()

urlpatterns.forEach { config in
    _pjango_runtime_urls_urlToConfig[config.url] = config
    if let name = config.name {
        _pjango_runtime_urls_nameToConfig[name] = config
    }
}


var routes = Routes.init()

_pjango_runtime_urls_urlToConfig.forEach { (url, config) in
    routes.add(uri: url, handler: config.handle)
}

// MARK: - Server
_pjango_runtime_log.info("Starting...")
let _pjango_runtime_server = HTTPServer.init()
_pjango_runtime_server.documentRoot = PCSettings.shared.staticUrl
_pjango_runtime_server.serverPort = port
_pjango_runtime_server.addRoutes(routes)
do {
    try _pjango_runtime_server.start()
} catch {
    _pjango_runtime_log.error(error)
}

