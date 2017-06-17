//
//  model.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import Pjango_Core

struct TimeZoneDate: PCViewable {
    
    var zone: String
    var date: String
    
    init(date: Date, zone: String) {
        self.zone = zone
        let timeZone = TimeZone.init(identifier: zone)
        let formatter = DateFormatter.init()
        formatter.timeZone = timeZone
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        self.date = formatter.string(from: date)
    }
    
    func toViewParam() -> PCViewParam {
        return [
            "_pjango_param_zone": zone,
            "_pjango_param_date": date,
        ]
    }
}
