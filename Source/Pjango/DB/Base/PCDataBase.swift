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
        _pjango_core_log.debug("Exc sql: \(sql)")
        return doQuery(sql)
    }
    
    open func doQuery(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? { return nil }
    
    open func isSchemeExist(_ scheme: String) -> Bool {
        guard let ret = query(PCSqlUtility.selectScheme(scheme)) else {
            return false
        }
        if ret.count >= 1 {
            return true
        } else {
            return false
        }
    }
    
    open func isTableExist(_ table: String) -> Bool {
        return query(PCSqlUtility.selectTable(config.name, table)) != nil ? true : false
    }
    
    open func createScheme() {
        guard query(PCSqlUtility.createScheme(config.name)) != nil else {
            _pjango_core_log.error("Failed on creating scheme `\(config.name)`")
            return
        }
        _pjango_core_log.info("Success on creating scheme `\(config.name)`")
    }
    
    open func dropScheme() {
        guard query(PCSqlUtility.dropScheme(config.name)) != nil else {
            _pjango_core_log.error("Failed on droping scheme `\(config.name)`")
            return
        }
        _pjango_core_log.info("Sucess on droping scheme `\(config.name)`")
    }
    
    open func createTable(_ model: PCModel) {
        guard query(PCSqlUtility.createTable(config.name, model.tableName, model._pjango_core_model_fields)) != nil else {
            _pjango_core_log.error("Failed on creating table `\(config.name).\(model.tableName)`")
            return
        }
        _pjango_core_log.info("Success on creating table `\(config.name).\(model.tableName)`")
    }
    
    open func dropTable(_ model: PCMetaModel) {
        dropTable(model.tableName)
    }
    
    open func dropTable(_ table: String) {
        guard query(PCSqlUtility.dropTable(config.name, table)) != nil else {
            _pjango_core_log.error("Failed on droping table `\(config.name).\(table)`")
            return
        }
        _pjango_core_log.info("Success on droping table `\(config.name).\(table)`")
    }
    
    open func selectTable(_ model: PCMetaModel) -> [PCDataBaseRecord]? {
        return selectTable(model.tableName)
    }
    
    open func selectTable(_ table: String) -> [PCDataBaseRecord]? {
        return query(PCSqlUtility.selectTable(config.name, table))
    }
}
