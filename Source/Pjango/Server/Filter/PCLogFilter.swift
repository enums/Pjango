//
//  PCLogFilter.swift
//  Pjango-Project
//
//  Created by 郑宇琦 on 2017/6/21.
//
//

import Foundation
import PerfectHTTP

internal class PCLogFilter: HTTPRequestFilter, HTTPResponseFilter {
    
    //Request Filter
    func filter(request: HTTPRequest, response: HTTPResponse, callback: (HTTPRequestFilterResult) -> ()) {
        let url = request.getFullUrl()
        let method = request.method
        let host = request.remoteAddress.host
        let port = request.remoteAddress.port
        _pjango_core_log.info("Req:      [\(method)][\(host)][\(port)]: \(url)")
        callback(.continue(request, response))
    }
    
    //Reponse Filter
    func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        let code = response.status.code
        let request = response.request
        let url = request.getFullUrl()
        let method = request.method
        let host = request.remoteAddress.host
        let port = request.remoteAddress.port
        _pjango_core_log.info("Res: [\(code)][\(method)][\(host)][\(port)]: \(url)")
        callback(.continue)
    }
    
    func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        callback(.continue)
    }
    
}
