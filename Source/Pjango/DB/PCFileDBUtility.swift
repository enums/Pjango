//
//  PCFileDBUtility.swift
//  Pjango-Dev
//
//  Created by 郑宇琦 on 2017/7/2.
//
//

import Foundation
import PerfectLib

internal class PCFileDBUtility {
    
    
    internal static func dirPathForSchema(path: String, schema: String) -> String {
        return "\(path)/\(schema)"
    }
    
    internal static func filePathForTable(path: String, schema: String, table: String) -> String {
        return "\(dirPathForSchema(path: path, schema: schema))/\(table).json"
    }
    
    internal static func filePathForTable(path: String, schema: String, model: PCModel) -> String {
        let table = model.tableName
        return filePathForTable(path: path, schema: schema, table: table)
    }
    
}
