//
//  PCModel.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

public typealias PCMetaModel = PCModel

open class PCModel: PCObject, PCViewable {
    
    internal var _pjango_core_model_fields = Array<PCDataBaseField>()

    internal var _pjango_core_model_fields_key = Array<String>()
    
    internal var _pjango_core_model_fields_type = Dictionary<String, PCDataBaseFieldType>()
    
    internal var _pjango_core_model_fields_value = Dictionary<String, PCModelDataBaseFieldType>()
    
    internal func _pjango_core_model_get_filed_data(key: String) -> PCModelDataBaseFieldType? {
        guard let type = _pjango_core_model_fields_type[key], let value = _pjango_core_model_fields_value[key] else {
            return nil
        }
        switch type {
        case .unknow: return nil
        case .string: return value as? String
        case .int: return value as? Int
        }
    }
    
    internal func _pjango_core_model_set_field_data(index: Int, value: Any) {
        guard index < _pjango_core_model_fields_key.count else {
            return
        }
        let key = _pjango_core_model_fields_key[index]
        _pjango_core_model_set_field_data(key: key, value: value)
    }
    
    
    internal func _pjango_core_model_set_field_data(key: String, value: Any) {
        guard let type = _pjango_core_model_fields_type[key] else {
            return
        }
        switch type {
        case .string:
            guard let strValue = value as? String else {
                return
            }
            _pjango_core_model_fields_value[key] = strValue
        case .int:
            let intValue: Int
            if let int = value as? Int {
                intValue = int
            } else if let str = value as? String, let int = Int(str) {
                intValue = int
            } else {
                return
            }
            _pjango_core_model_fields_value[key] = intValue
        default: return
        }
    }
    
    internal static var _pjango_core_model_cache = Dictionary<String, Array<PCDataBaseRecord>>()
    
    internal static var _pjango_core_model_cache_time = Dictionary<String, TimeInterval>()
    
    internal var _pjango_core_model_id: Int? = nil
    
    open var tableName: String {
        return ""
    }
    
    open class var cacheTime: TimeInterval? {
        return nil
    }
    
    open class func cacheRemove() {
        _pjango_core_model_cache[_pjango_core_class_name] = nil
        _pjango_core_model_cache_time[_pjango_core_class_name] = nil
    }
    
    open class func queryObjects() -> [PCModel]? {
        guard let meta = PjangoRuntime._pjango_runtime_models_name2meta[_pjango_core_class_name] else {
            return nil
        }
        let nowTime = Date.init()
        let records: [PCDataBaseRecord]
        if let cacheTime = cacheTime,
            let cache = _pjango_core_model_cache[_pjango_core_class_name],
            let lastCacheTime = _pjango_core_model_cache_time[_pjango_core_class_name],
            nowTime.timeIntervalSince1970 - lastCacheTime <= cacheTime {
            records = cache
        } else {
            guard let recordsFromDB = PjangoRuntime._pjango_runtime_database.selectTable(model: meta) else {
                return nil
            }
            _pjango_core_model_cache[_pjango_core_class_name] = recordsFromDB
            _pjango_core_model_cache_time[_pjango_core_class_name] = nowTime.timeIntervalSince1970
            records = recordsFromDB
        }
        return records.flatMap { record in
            var record = record
            guard let idStr = record.removeFirst(), let id = Int(idStr) else {
                return nil
            }
            let model = self.init()
            model._pjango_core_model_id = id
            for i in 0..<record.count {
                model._pjango_core_model_set_field_data(index: i, value: record[i] as Any)
            }
            return model
        }
    }
    
    open class func insertObject(_ model: PCModel) -> Bool {
        if PjangoRuntime._pjango_runtime_database.insertModel(model) == true {
            cacheRemove()
            return true
        } else {
            return false
        }
    }
    
    @discardableResult
    open class func updateObject(_ model: PCModel) -> Bool {
        if PjangoRuntime._pjango_runtime_database.updateModel(model) == true {
            cacheRemove()
            return true
        } else {
            return false
        }
    }
    
    open static var meta: PCMetaModel {
        return self.init()
    }
    
    required public override init() {
        super.init()
        doRegisterFields(registerFields())
    }
    
    open func registerFields() -> [PCDataBaseField] {
        return []
    }
    
    fileprivate func doRegisterFields(_ fields: [PCDataBaseField]) {
        _pjango_core_model_fields = fields
        _pjango_core_model_fields_key = fields.map {
            $0.model = self
            return $0.name
        }
        fields.forEach {
            $0._pjango_core_set_model_block?()
            $0._pjango_core_set_model_block = nil
            _pjango_core_model_fields_type[$0.name] = $0.type
        }
    }
    
    open var viewParamPrefix: String {
        return "_pjango_param_table_\(tableName)_"
    }
    
    public func toViewParam() -> PCViewParam {
        var param = PCViewParam()
        _pjango_core_model_fields_value.forEach { (key, value) in
            param["\(viewParamPrefix)\(key)"] = value
        }
        return param
    }
    
}

