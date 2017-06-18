//
//  model.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import Pjango_Core

public func _pjango_user_registerModels() -> Array<PCMetaModel> {
    return [
        TimeZoneModel.init()
    ]
}


class TimeZoneModel: PCModel {
    
    override var tableName: String {
        return "TimeZone"
    }
    
    var zone = PCDataBaseField.init(name: "ZONE", type: .string, length: 3) { didSet { zone.model = self } }
    var memo = PCDataBaseField.init(name: "MEMO", type: .string, length: 50) { didSet { memo.model = self } }
    
}
