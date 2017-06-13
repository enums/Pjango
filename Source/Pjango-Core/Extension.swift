//
//  Extension.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation

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
