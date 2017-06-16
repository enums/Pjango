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
    func _pjango_safe_setResponse(_ body: String?) {
        self.setHeader(.contentType, value: "text/html")
        self.setBody(string: body ?? "Error")
        self.completed()
    }
}
