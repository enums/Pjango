//
//  Extension.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import PerfectHTTP

fileprivate var dateFormatter = { () -> DateFormatter in
    let that = DateFormatter.init()
    that.timeZone = TimeZone.init(secondsFromGMT: 8 * 3600)
    that.dateFormat = "YYYY-MM-dd HH:mm:ss"
    return that
}()

public extension Date {
    var stringValue: String {
        get {
            return dateFormatter.string(from: self)
        }
    }
}

public extension HTTPResponse {
    
    func _pjango_safe_setBody(_ body: String?, _ setContentLength: Bool = true) {
        self.setBody(string: body ?? (ERROR_TEMPLATE_INTERNAL?.getTemplate() ?? ERROR_MSG_INTERNAL))
        if setContentLength {
            self.setHeader(.contentLength, value: "\(self.bodyBytes.count)")
        }
    }
}

public extension HTTPRequest {
    func getUrlParam(key: String, defaultValue: String) -> String {
        return self.param(name: key) ?? defaultValue
    }
    
    func getFullUrl() -> String {
        var url = self.header(.host) ?? "null"
        url += self.path
        if self.queryParams.count > 0 {
            url += "?"
            for (key, value) in self.queryParams.dropLast() {
                url += "\(key)=\(value)&"
            }
            let (key, value) = self.queryParams.last!
            url += "\(key)=\(value)"
        }
        return url
    }
}
