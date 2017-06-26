//
//  PCHTTPFilterPlugin.swift
//  Pjango-Dev
//
//  Created by 郑宇琦 on 2017/6/26.
//
//

import Foundation
import PerfectHTTP

open class PCHTTPFilterPlugin: PCPlugin, HTTPRequestFilter, HTTPResponseFilter {
    
    open var priority: HTTPFilterPriority {
        return .low
    }
    
    open func requestFilter(req: HTTPRequest, res: HTTPResponse) -> Bool { return true }
    
    open func responseFilterHeader(req: HTTPRequest, res: HTTPResponse) -> Bool { return true }
    
    open func responseFilterBody(req: HTTPRequest, res: HTTPResponse) -> Bool { return true }
    
    public func filter(request: HTTPRequest, response: HTTPResponse, callback: (HTTPRequestFilterResult) -> ()) {
        if requestFilter(req: request, res: response) {
            callback(.continue(request, response))
        } else {
            callback(.halt(request, response))
        }
    }
    
    public func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        if responseFilterHeader(req: response.request, res: response) {
            callback(.continue)
        } else {
            callback(.done)
        }
    }
    
    public func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        if responseFilterBody(req: response.request, res: response) {
            callback(.continue)
        } else {
            callback(.done)
        }
    }
}
