//
//  PCLogFilterPlugin.swift
//  Pjango-Project
//
//  Created by 郑宇琦 on 2017/6/21.
//
//

import Foundation
import PerfectHTTP

open class PCLogFilterPlugin: PCHTTPFilterPlugin {
    
    open override func requestFilter(req: HTTPRequest, res: HTTPResponse) -> Bool {
        let url = req.getFullUrl()
        let method = req.method
        let host = req.serverAddress.host
        let port = req.serverAddress.port
        _pjango_core_log.info("Req:      [\(method)][\(host)][\(port)]: \(url)")
        return true
    }
    
    open override func responseFilterHeader(req: HTTPRequest, res: HTTPResponse) -> Bool {
        let code = res.status.code
        let url = req.getFullUrl()
        let method = req.method
        let host = req.serverAddress.host
        let port = req.serverAddress.port
        _pjango_core_log.info("Res: [\(code)][\(method)][\(host)][\(port)]: \(url)")
        return true
    }
    
    
}
