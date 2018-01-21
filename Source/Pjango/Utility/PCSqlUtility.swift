//
//  PCSqlUtility.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation

public typealias PCSqlStatement = String
public typealias PCDataBaseRecord = [String]

final public class PCSqlUtility {
    
    public static func createSchema(_ name: String) -> PCSqlStatement {
        return "CREATE SCHEMA `\(name)` DEFAULT CHARACTER SET utf8mb4;"
    }
    
    public static func dropSchema(_ name: String) -> PCSqlStatement {
        return "DROP DATABASE `\(name)`;"
    }
    
    public static func selectSchema(_ name: String) -> PCSqlStatement {
        return "SELECT * FROM information_schema.SCHEMATA where SCHEMA_NAME='\(name)';"
    }
    
    internal static func schemaAndTableToStr(_ schema: String? = nil, _ table: String) -> String {
        if let schema = schema {
            return "`\(schema)`.`\(table)`"
        } else {
            return "`\(table)`"
        }
    }
    
    public static func createTable(_ schema: String? = nil, _ table: String, _ fields: Array<PCDataBaseField>) -> PCSqlStatement {
        let fieldsStr = fields.reduce("") {
            $0 + ", " + $1._pjango_core_toSql()
        }
        return "CREATE TABLE \(schemaAndTableToStr(schema, table)) (`_pjango_id` INT AUTO_INCREMENT \(fieldsStr), PRIMARY KEY (`_pjango_id`));"
    }
    
    public static func dropTable(_ schema: String? = nil, _ table: String) -> PCSqlStatement {
        return "DROP TABLE \(schemaAndTableToStr(schema, table));"
    }
    
    public static func selectTable(_ schema: String? = nil, _ table: String, _ fields: String = "*", ext: String? = nil) -> PCSqlStatement {
        return "SELECT \(fields) FROM \(schemaAndTableToStr(schema, table)) \(ext ?? "");"
    }
    
    public static func insertRecord(_ schema: String? = nil, _ table: String, _ record: PCDataBaseRecord) -> PCSqlStatement {
        let recordStr = record.reduce("'0'") {
            "\($0), '\(($1.replacingOccurrences(of: "'", with: "\\'")))'"
        }
        return "INSERT INTO \(schemaAndTableToStr(schema, table)) VALUES (\(recordStr))"
    }
    
    public static func updateRecord(_ schema: String? = nil, _ table: String, id: Int64, fields: [String], record: PCDataBaseRecord) -> PCSqlStatement {
        var updateStr = ""
        for i in 0..<fields.count {
            let field = fields[i]
            let value = record[i]
            updateStr += "`\(field)`='\(value)'"
            if i < fields.count - 1 {
                updateStr += ","
            }
        }
        return "UPDATE \(schemaAndTableToStr(schema, table)) SET \(updateStr) WHERE `_pjango_id`='\(id)';"
    }
}
