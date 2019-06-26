//
//  PCDataBase.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

import Foundation

public enum PCDataBaseState {
    case empty
    case inited
    case setuped
    case connected
    case disconnected
}

open class PCDataBase {
    
    open var schema: String? {
        return nil
    }
    
    public let config: PCDataBaseConfig
    open var state: PCDataBaseState
    
    public let _pjango_core_database_lock = NSLock.init()
    
    public init(config: PCDataBaseConfig) {
        self.config = config
        self.state = .inited
    }
    
    public static var empty: PCDataBase {
        let database = PCDataBase.init(config: PCDataBaseConfig.init())
        database.state = .empty
        return database
    }
    
    open func setup() {
        _pjango_core_database_lock.lock()
        defer {
            _pjango_core_database_lock.unlock()
        }
        guard state != .empty else {
            return
        }
        doSetup()
        self.state = .setuped
    }
    
    open func doSetup() { }
    
    open func connect() {
        _pjango_core_database_lock.lock()
        defer {
            _pjango_core_database_lock.unlock()
        }
        guard state == .setuped || state == .disconnected else {
            return
        }
        doConnect()
        self.state = .connected
    }
    
    open func doConnect() { }
    
    @discardableResult
    open func query(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? {
        _pjango_core_database_lock.lock()
        defer {
            _pjango_core_database_lock.unlock()
        }
        guard state == .connected else {
            return nil
        }
        _pjango_core_log.debug("Query: \(sql)")
        return doQuery(sql)
    }
    
    open func doQuery(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? { return nil }
    
    open func isSchemaExist(_ schema: String) -> Bool {
        guard let ret = query(PCSqlUtility.selectSchema(schema)) else {
            return false
        }
        if ret.count >= 1 {
            return true
        } else {
            return false
        }
    }
    
    
    open func isTableExist(_ table: String) -> Bool {
        return query(PCSqlUtility.selectTable(schema, table, ext: "LIMIT 1")) != nil ? true : false
    }
    
    open func createSchema() {
        guard let schema = schema else {
            _pjango_core_log.error("Failed on creating schema. Schema value is nil.")
            return
        }
        guard query(PCSqlUtility.createSchema(schema)) != nil else {
            _pjango_core_log.error("Failed on creating schema `\(schema)`")
            return
        }
        _pjango_core_log.info("Success on creating schema `\(schema)`")
    }
    
    open func dropSchema() {
        guard let schema = schema else {
            _pjango_core_log.error("Failed on droping schema. Schema value is nil.")
            return
        }
        guard query(PCSqlUtility.dropSchema(schema)) != nil else {
            _pjango_core_log.error("Failed on droping schema `\(schema)`")
            return
        }
        _pjango_core_log.info("Sucess on droping schema `\(schema)`")
    }
    
    open func createTable(model: PCMetaModel) {
        guard query(PCSqlUtility.createTable(schema, model.tableName, model._pjango_core_model_fields)) != nil else {
            _pjango_core_log.error("Failed on creating table \(PCSqlUtility.schemaAndTableToStr(schema, model.tableName))")
            return
        }
        _pjango_core_log.info("Success on creating table \(PCSqlUtility.schemaAndTableToStr(schema, model.tableName))")
    }
    
    open func dropTable(model: PCMetaModel) {
        dropTable(model.tableName)
    }
    
    open func dropTable(_ table: String) {
        guard query(PCSqlUtility.dropTable(schema, table)) != nil else {
            _pjango_core_log.error("Failed on droping table \(PCSqlUtility.schemaAndTableToStr(schema, table))")
            return
        }
        _pjango_core_log.info("Success on droping table \(PCSqlUtility.schemaAndTableToStr(schema, table))")
    }
    
    open func selectTable(model: PCMetaModel, ext: String? = nil) -> [PCDataBaseRecord]? {
        return selectTable(table: model.tableName, ext: ext)
    }
    
    open func selectTable(table: String, ext: String? = nil) -> [PCDataBaseRecord]? {
        return query(PCSqlUtility.selectTable(schema, table, ext: ext))
    }
    
    @discardableResult
    open func insertModel(_ model: PCModel) -> Bool {
        let record = model._pjango_core_model_fields.compactMap { (field) -> String? in
            switch field.type {
            case .string: return field.strValue
            case .int: return "\(field.intValue)"
            case .text: return field.strValue
            case .unknow: return nil
            }
        }
        guard record.count == model._pjango_core_model_fields.count else {
            return false
        }
        guard query(PCSqlUtility.insertRecord(schema, model.tableName, record)) != nil else {
            _pjango_core_log.error("Failed on insert model \(PCSqlUtility.schemaAndTableToStr(schema, model.tableName))")
            return false
        }
        return true
    }
    
    @discardableResult
    open func updateModel(_ model: PCModel) -> Bool {
        guard let id = model._pjango_core_model_id else {
            return false
        }
        let updateStr = model._pjango_core_model_fields_key.compactMap { (key) -> String? in
            guard let type = model._pjango_core_model_fields_type[key], let value = model._pjango_core_model_get_filed_data(key: key) else {
                return nil
            }
            switch type {
            case .string:
                guard let strValue = value as? String else {
                    return nil
                }
                return strValue
            case .int:
                guard let intValue = value as? Int else {
                    return nil
                }
                return "\(intValue)"
            case .text:
                guard let textValue = value as? String else {
                    return nil
                }
                return textValue
            case .unknow: return nil
            }
        }
        guard updateStr.count == model._pjango_core_model_fields_key.count else {
            return false
        }
        guard query(PCSqlUtility.updateRecord(schema, model.tableName, id: id, fields: model._pjango_core_model_fields_key, record: updateStr)) != nil else {
            _pjango_core_log.error("Failed on update model \(PCSqlUtility.schemaAndTableToStr(schema, model.tableName))")
            return false
        }
        return true
    }
    
}
