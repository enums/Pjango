//
//  Server.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import PerfectHTTPServer
import PerfectHTTP
import Pjango_Core

func _pjango_runtime_setServer(port: UInt16) -> HTTPServer {
    let routeList = _pjango_core_runtime_urls_url2config.map { (url, config) in
        Route.init(uri: url, handler: config.handle)
    }
    let routes = Routes.init(routeList)
    let server = HTTPServer.init()
    server.documentRoot = STATIC_URL
    server.serverPort = port
    server.addRoutes(routes)
    
    return server
}
