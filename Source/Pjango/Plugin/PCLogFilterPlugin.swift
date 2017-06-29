//
//  PCLogFilterPlugin.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/21.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectHTTP

open class PCLogFilterPlugin: PCHTTPFilterPlugin {
    
    open override func requestFilter(req: HTTPRequest, res: HTTPResponse) -> Bool {
        let url = (req.header(.host) ?? "nil") + req.uri
        let method = req.method
        let host = req.remoteAddress.host
        let port = req.remoteAddress.port
        _pjango_core_log.info("Req:      [\(method)][\(host)][\(port)]: \(url)")
        return true
    }
    
    open override func responseFilterHeader(req: HTTPRequest, res: HTTPResponse) -> Bool {
        let code = res.status.code
        let url = (req.header(.host) ?? "nil") + req.uri
        let method = req.method
        let host = req.remoteAddress.host
        let port = req.remoteAddress.port
        _pjango_core_log.info("Res: [\(code)][\(method)][\(host)][\(port)]: \(url)")
        return true
    }
    
    
}
