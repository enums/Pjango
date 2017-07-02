//
//  PCFileDBDataBase.swift
//  Pjango-Dev
//
//  Created by 郑宇琦 on 2017/7/2.
//
//

import Foundation
import PerfectLib
import SwiftyJSON

fileprivate let _pjango_filedb_init_content = "_pjango_empty_table"

open class PCFileDBDataBase: PCDataBase {
    
    open override var schema: String? {
        return (self.config as! PCFileDBConfig).schema
    }
    
    open var path: String {
        return (self.config as! PCFileDBConfig).path
    }

    public convenience init?(param: [String: Any]) {
        guard let config = PCFileDBConfig.init(param: param) else {
            _pjango_core_log.debug("Oops! Faied on create database config!")
            return nil
        }
        self.init(config: config)
    }
    
    open override func isSchemaExist(_ schema: String) -> Bool {
        let dir = Dir.init(PCFileDBUtility.dirPathForSchema(path: path, schema: schema))
        return dir.exists
    }
    
    open override func isTableExist(_ table: String) -> Bool {
        let file = File.init(PCFileDBUtility.filePathForTable(path: path, schema: schema!, table: table))
        return file.exists
    }
    
    open override func createSchema() {
        _pjango_filedb_doWithLocked {
            let dir = Dir.init(PCFileDBUtility.dirPathForSchema(path: path, schema: schema!))
            do {
                if dir.exists {
                    try dir.delete()
                }
                try dir.create()
            } catch {
                _pjango_core_log.error("Failed on creating schema.")
            }
        }
    }
    
    open override func dropSchema() {
        _pjango_filedb_doWithLocked {
            let dir = Dir.init(PCFileDBUtility.dirPathForSchema(path: path, schema: schema!))
            do {
                try dir.delete()
            } catch {
                _pjango_core_log.error("Failed on droping schema.")
            }
        }
    }
    
    open override func createTable(model: PCMetaModel) {
        _pjango_filedb_doWithLocked {
            let file = File.init(PCFileDBUtility.filePathForTable(path: path, schema: schema!, model: model))
            if file.exists {
                file.delete()
            }
            do {
                try file.open(.readWrite)
                try file.write(string: _pjango_filedb_init_content)
                defer {
                    file.close()
                }
            } catch {
                _pjango_core_log.error("Failed on creating table.")
            }
        }
    }
    
    open override func dropTable(model: PCMetaModel) {
        dropTable(model.tableName)
    }
    
    open override func dropTable(_ table: String) {
        _pjango_filedb_doWithLocked {
            let file = File.init(PCFileDBUtility.filePathForTable(path: path, schema: schema!, table: table))
            if file.exists {
                file.delete()
            }
        }
    }
    
    open override func selectTable(model: PCMetaModel) -> [PCDataBaseRecord]? {
        return selectTable(table: model.tableName)
    }
    
    open override func selectTable(table: String) -> [PCDataBaseRecord]? {
        return _pjango_filedb_doWithLocked {
            let file = File.init(PCFileDBUtility.filePathForTable(path: path, schema: schema!, table: table))
            guard file.exists else {
                _pjango_core_log.error("Failed on selecting table.")
                return nil
            }
            guard let list = _pjango_filedb_build_list_from_file(file) else {
                _pjango_core_log.error("Failed on selecting table.")
                return nil
            }
            return list
        }
    }
    
    
    @discardableResult
    open override func insertModel(_ model: PCModel) -> Bool {
        var record = model._pjango_core_model_fields.flatMap { (field) -> String? in
            switch field.type {
            case .string: return field.strValue
            case .int: return "\(field.intValue)"
            case .unknow: return nil
            }
        }
        guard record.count == model._pjango_core_model_fields.count else {
            return false
        }
        let file = File.init(PCFileDBUtility.filePathForTable(path: path, schema: schema!, model: model))
        guard var records = _pjango_filedb_build_list_from_file(file) else {
            return false
        }
        record.insert("\(Int64(Date.init().timeIntervalSince1970 * 10000))", at: 0)
        records.append(record)
        guard _pjango_filedb_save_list_to_file(records, file: file) else {
            _pjango_core_log.error("Failed on inserting model.")
            return false
        }
        return true
    }

    @discardableResult
    open override func updateModel(_ model: PCModel) -> Bool {
        guard let id = model._pjango_core_model_id else {
            return false
        }
        let updateStr = model._pjango_core_model_fields_key.flatMap { (key) -> String? in
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
            case .unknow: return nil
            }
        }
        guard updateStr.count == model._pjango_core_model_fields_key.count else {
            return false
        }
        let file = File.init(PCFileDBUtility.filePathForTable(path: path, schema: schema!, model: model))
        guard var records = _pjango_filedb_build_list_from_file(file) else {
            return false
        }
        for i in 0..<records.count {
            if records[i][0] == "\(id)" {
                records[i] = updateStr
                records[i].insert("\(id)", at: 0)
                guard _pjango_filedb_save_list_to_file(records, file: file) else {
                    _pjango_core_log.error("Failed on updating model.")
                    return false
                }
                return true
            }
        }
        _pjango_core_log.error("Failed on updating model.")
        return false
    }
    
    
    @discardableResult
    internal func _pjango_filedb_doWithLocked<T>(_ foo: ()->T) -> T{
        _pjango_core_database_lock.lock()
        defer {
            _pjango_core_database_lock.unlock()
        }
        return foo()
    }
    
    internal func _pjango_filedb_build_list_from_file(_ file: File) -> [PCDataBaseRecord]? {
        do {
            try file.open(.readWrite)
            defer {
                file.close()
            }
            let str = try file.readString()
            let json: JSON
            if str == _pjango_filedb_init_content {
                json = JSON.init([
                        "objs": [[String]]()
                    ])
            } else {
                json = JSON.parse(str)
            }
            guard let jsonArray = json["objs"].array else {
                return nil
            }
            var result = [PCDataBaseRecord]()
            for jsonRecord in jsonArray {
                var record = PCDataBaseRecord()
                guard let jsonFieldList = jsonRecord.array else {
                    continue
                }
                for jsonField in jsonFieldList {
                    guard let value = jsonField.string else {
                        break
                    }
                    record.append(value)
                }
                result.append(record)
            }
            return result
        } catch {
            return nil
        }
    }
    
    internal func _pjango_filedb_save_list_to_file(_ list: [PCDataBaseRecord], file: File) -> Bool {
        let json = JSON.init([
                "objs": list
            ])
        let str = json.description
        do {
            file.delete()
            try file.open(.readWrite)
            defer {
                file.close()
            }
            try file.write(string: str)
            return true
        } catch {
            return false
        }
    }

}
