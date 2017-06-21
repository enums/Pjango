//
//  Pjango.swift
//  Pjango-Core
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import PerfectHTTP

public typealias PCUrlHandle = RequestHandler

public func pjangoUrl(_ url: String, _ name: String? = nil, _ handleBlock: @escaping (() -> PCUrlHandle)) -> PCUrlConfig {
    return pjangoUrl(url, name, handleBlock())
}

public func pjangoUrl(_ url: String, _ name: String? = nil, _ handle: @escaping PCUrlHandle) -> PCUrlConfig {
    return PCUrlConfig(url: url, handle: handle, name: name)
}

public func pjangoUrlReverse(_ name: String) -> String {
    return PjangoRuntime._pjango_runtime_urls_name2config[name]?.url ?? ""
}

public func pjangoHttpResponse(_ msg: String) -> PCUrlHandle {
    return pjangoHttpResponse { req, res in
        res._pjango_safe_setBody(msg)
    }
}

public func pjangoHttpResponse(_ handle: @escaping RequestHandler) -> PCUrlHandle {
    return handle
}
