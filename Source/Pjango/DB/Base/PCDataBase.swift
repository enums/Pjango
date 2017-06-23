//
//  PCDataBase.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
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
    
    open let config: PCDataBaseConfig
    open var state: PCDataBaseState
    
    public init(config: PCDataBaseConfig) {
        self.config = config
        self.state = .inited
    }
    
    open static var empty: PCDataBase {
        let database = PCDataBase.init(config: PCDataBaseConfig.init())
        database.state = .empty
        return database
    }
    
    open func setup() {
        guard state != .empty else {
            return
        }
        doSetup()
        self.state = .setuped
    }
    
    open func doSetup() { }
    
    open func connect() {
        guard state == .setuped || state == .disconnected else {
            return
        }
        doConnect()
        self.state = .connected
    }
    
    open func doConnect() { }
    
    @discardableResult
    open func query(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? {
        guard state == .connected else {
            return nil
        }
        _pjango_core_log.debug("Query: \(sql)")
        return doQuery(sql)
    }
    
    open func doQuery(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? { return nil }
    
    open func isSchemaExist(_ scheme: String) -> Bool {
        guard let ret = query(PCSqlUtility.selectSchema(scheme)) else {
            return false
        }
        if ret.count >= 1 {
            return true
        } else {
            return false
        }
    }
    
    
    open func isTableExist(_ table: String) -> Bool {
        return query(PCSqlUtility.selectTable(schema, table)) != nil ? true : false
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
    
    open func createTable(model: PCModel) {
        guard query(PCSqlUtility.createTable(schema, model.tableName, model._pjango_core_model_fields)) != nil else {
            _pjango_core_log.error("Failed on creating table \(PCSqlUtility.schemeAndTableToStr(schema, model.tableName))")
            return
        }
        _pjango_core_log.info("Success on creating table \(PCSqlUtility.schemeAndTableToStr(schema, model.tableName))")
    }
    
    open func dropTable(model: PCMetaModel) {
        dropTable(model.tableName)
    }
    
    open func dropTable(_ table: String) {
        guard query(PCSqlUtility.dropTable(schema, table)) != nil else {
            _pjango_core_log.error("Failed on droping table \(PCSqlUtility.schemeAndTableToStr(schema, table))")
            return
        }
        _pjango_core_log.info("Success on droping table \(PCSqlUtility.schemeAndTableToStr(schema, table))")
    }
    
    open func selectTable(model: PCMetaModel) -> [PCDataBaseRecord]? {
        return selectTable(table: model.tableName)
    }
    
    open func selectTable(table: String) -> [PCDataBaseRecord]? {
        return query(PCSqlUtility.selectTable(schema, table))
    }
}
