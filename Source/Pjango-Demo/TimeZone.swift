//
//  TimeZone.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
//

import Foundation
import Pjango_Core

class TimeZoneModel: PCModel {
    
    override var tableName: String {
        return "TimeZone"
    }
    
    var zone = PCDataBaseField.init(name: "ZONE", type: .string, length: 3) { didSet { zone.model = self } }
    var memo = PCDataBaseField.init(name: "MEMO", type: .string, length: 50) { didSet { memo.model = self } }
    
}

class TimeZoneView: PCListView {
    
    override var templateName: String {
        return "time_zone.html"
    }
    
    override var querySet: Array<PCViewable>? {
        return TimeZoneModel.queryObjects()
    }
    
}

