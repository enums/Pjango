//
//  PCSqlUtility.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

public typealias PCSqlStatement = String
public typealias PCDataBaseRecord = [String?]

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
    
    internal static func schemeAndTableToStr(_ schema: String? = nil, _ table: String) -> String {
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
        return "CREATE TABLE \(schemeAndTableToStr(schema, table)) (`_pjango_id` INT AUTO_INCREMENT \(fieldsStr), PRIMARY KEY (`_pjango_id`));"
    }
    
    public static func dropTable(_ schema: String? = nil, _ table: String) -> PCSqlStatement {
        return "DROP TABLE \(schemeAndTableToStr(schema, table));"
    }
    
    public static func selectTable(_ schema: String? = nil, _ table: String, _ fields: String = "*") -> PCSqlStatement {
        return "SELECT \(fields) FROM \(schemeAndTableToStr(schema, table));"
    }
    
    public static func insertRecord(_ schema: String, _ table: String, _ record: PCDataBaseRecord) -> PCSqlStatement {
        let recordStr = record.reduce("'0'") {
            $0 + ", " + ($1 ?? "")
        }
        return "INSERT INTO \(schemeAndTableToStr(schema, table)) VALUES (\(recordStr))"
    }
    
}
