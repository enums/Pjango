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
    
    var zone = PCDataBaseField.init(name: "ZONE", type: .string, length: 3)
    var memo = PCDataBaseField.init(name: "MEMO", type: .string, length: 50)
    
    override func registerFields() -> [PCDataBaseField] {
        return [
            zone, memo
        ]
    }
}

class TimeZoneView: PCListView {
    
    override var templateName: String {
        return "time_zone.html"
    }
    
    override var querySet: Array<PCModel>? {
       return TimeZoneModel.queryObjects()
    }
    
    override func viewParamUserField(withModel model: PCModel) -> PCViewParam? {
        let model = model as! TimeZoneModel
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone.init(identifier: model.zone.value as! String)
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        return [
            "_pjango_param_table_TimeZone_TIME": formatter.string(from: Date.init())
        ]
    }
    
}

