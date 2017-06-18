//
//  PCDataBase.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import MySQL

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
        return doQuery(sql)
    }
    
    open func doQuery(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? { return nil }
    
    open func isSchemeExist(_ scheme: String) -> Bool {
        let sql = PCSqlUtility.selectScheme(scheme)
        guard let ret = query(sql) else {
            return false
        }
        if ret.count >= 1 {
            return true
        } else {
            return false
        }
    }
    
    open func isTableExist(_ table: String) -> Bool {
        let sql = PCSqlUtility.selectTable(config.name, table)
        return query(sql) != nil ? true : false
    }
    
    open func createScheme() {
        query(PCSqlUtility.createScheme(config.name))
    }
    
    open func dropScheme() {
        query(PCSqlUtility.dropScheme(config.name))
    }
    
    open func createTable(_ model: PCModel) {
        query(PCSqlUtility.createTable(config.name, model.tableName, model._pjango_core_model_fields))
    }
    
    open func dropTable(_ model: PCMetaModel) {
        dropTable(model.tableName)
    }
    
    open func dropTable(_ table: String) {
        query(PCSqlUtility.dropTable(config.name, table))
    }
    
    open func selectTable(_ model: PCMetaModel) -> [PCDataBaseRecord]? {
        return selectTable(model.tableName)
    }
    
    open func selectTable(_ table: String) -> [PCDataBaseRecord]? {
        return query(PCSqlUtility.selectTable(config.name, table))
    }
}
