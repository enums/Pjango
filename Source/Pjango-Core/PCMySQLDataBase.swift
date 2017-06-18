//
//  PCMySQLDataBase.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation
import MySQL

open class PCMySQLDataBase: PCDataBase {
    
    internal let mysql = MySQL.init()
    
    override open func doSetup() {
        guard mysql.setOption(.MYSQL_OPT_RECONNECT, true) == true else {
            _pjango_core_log.error("Faied on setting MYSQL_OPT_RECONNECT!")
            return
        }
        guard mysql.setOption(.MYSQL_SET_CHARSET_NAME, "utf8mb4") == true else {
            _pjango_core_log.error("Failed on setting MYSQL_SET_CHARSET_NAME utf8mb4!")
            return
        }
    }
    
    override open func doConnect() {
        guard mysql.connect(host: config.host, user: config.user, password: config.password, port: UInt32(config.port)) else {
            _pjango_core_log.error("Failed on connecting database!")
            return
        }
    }
    
    override open func doQuery(_ sql: PCSqlStatement) -> [PCDataBaseRecord]? {
        guard mysql.query(statement: sql) else {
            return nil
        }
        guard let results = mysql.storeResults() else {
            return []
        }
        var resultArray = [PCDataBaseRecord]()
        while let row = results.next() {
            resultArray.append(row)
        }
        return resultArray
    }
}
