//
//  Extension.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation
import PerfectHTTP

fileprivate var dateFormatter = { () -> DateFormatter in
    let that = DateFormatter.init()
    that.timeZone = TimeZone.init(secondsFromGMT: 8 * 3600)
    that.dateFormat = "yyyy-MM-dd HH:mm:ss"
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
        self.setBody(string: body ?? "nil")
        if setContentLength {
            self.setHeader(.contentLength, value: "\(self.bodyBytes.count)")
        }
    }
    
    func _pjango_safe_setBody(_ body: [UInt8]?, _ setContentLength: Bool = true) {
        self.setBody(bytes: body ?? [])
        if setContentLength {
            self.setHeader(.contentLength, value: "\(self.bodyBytes.count)")
        }
    }
}

public extension HTTPRequest {
    func getUrlParam(key: String) -> String? {
        return self.param(name: key)
    }
}
