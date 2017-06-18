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
import MySQL
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

// MARK: - Configuration
_pjango_runtime_log.info("Configuring...")
_pjango_runtime_setSettings()
_pjango_runtime_setUrls()
_pjango_core_runtime_database = _pjango_runtime_setDataBase()
_pjango_runtime_setPlugin()

// MARK: - Server
_pjango_runtime_log.info("Starting...")
_pjango_core_runtime_server = _pjango_runtime_setServer(port: port)
do {
    try _pjango_core_runtime_server.start()
} catch {
    _pjango_runtime_log.error(error)
}

