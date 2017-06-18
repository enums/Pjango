//
//  Pjango.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import PerfectHTTP

public typealias PCUrlHandle = RequestHandler

public func pjangoUrl(_ url: String, _ handleBlock: @escaping (() -> PCUrlHandle), _ name: String? = nil) -> PCUrlConfig {
    let handle = handleBlock()
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func pjangoUrl(_ url: String, _ view: PCView.Type, _ name: String? = nil) -> PCUrlConfig {
    let handle: RequestHandler = { req, res in
        res._pjango_safe_setResponse(view.init().getTemplate())
    }
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func pjangoUrlReverse(_ name: String) -> String {
    return _pjango_core_runtime_urls_name2config[name]?.url ?? ""
}


public func pjangoHttpResponse(_ msg: String) -> PCUrlHandle {
    return pjangoHttpResponse { req, res in
        res._pjango_safe_setResponse(msg)
    }
}

public func pjangoHttpResponse(_ handle: @escaping RequestHandler) -> PCUrlHandle {
    return handle
}
