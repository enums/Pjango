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
    
    public static func createScheme(_ name: String) -> PCSqlStatement {
        return "CREATE SCHEMA `\(name)` ;"
    }
    
    public static func dropScheme(_ name: String) -> PCSqlStatement {
        return "DROP DATABASE `\(name)`;"
    }
    
    public static func selectScheme(_ name: String) -> PCSqlStatement {
        return "SELECT * FROM information_schema.SCHEMATA where SCHEMA_NAME='\(name)';"
    }
    
    public static func createTable(_ scheme: String, _ table: String, _ fields: Array<PCDataBaseField>) -> PCSqlStatement {
        let fieldsStr = fields.reduce("") {
            $0 + ", " + $1._pjango_core_toSql()
        }
        return "CREATE TABLE `\(scheme)`.`\(table)` (`_pjango_id` INT AUTO_INCREMENT \(fieldsStr), PRIMARY KEY (`_pjango_id`));"
    }
    
    public static func dropTable(_ scheme: String, _ table: String) -> PCSqlStatement {
        return "DROP TABLE `\(scheme)`.`\(table)`;"
    }
    
    public static func selectTable(_ scheme: String, _ table: String, _ fields: String = "*") -> PCSqlStatement {
        return "SELECT \(fields) FROM \(scheme).\(table);"
    }
    
    public static func insertRecord(_ scheme: String, _ table: String, _ record: PCDataBaseRecord) -> PCSqlStatement {
        let recordStr = record.reduce("'0'") {
            $0 + ", " + ($1 ?? "")
        }
        return "INSERT INTO `\(scheme)`.`\(table)` VALUES (\(recordStr))"
    }
    
}
