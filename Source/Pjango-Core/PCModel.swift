//
//  PCModel.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

public typealias PCMetaModel = PCModel

open class PCModel: PCViewable {
    
    open var _pjango_core_class_name: String {
        return String(describing: Mirror.init(reflecting: self).subjectType)
    }
    
    open static var _pjango_core_class_name: String {
        return String(describing: Mirror.init(reflecting: self).subjectType).components(separatedBy: ".")[0]
    }
    
    open var _pjango_core_fields = Array<PCDataBaseField>()

    open var _pjango_core_fields_key = Array<String>()
    
    open var _pjango_core_fields_value = Dictionary<String, PCModelDataBaseFieldType>()
    
    open var tableName: String {
        return ""
    }
    
    open static func queryObjects() -> [PCModel]? {
        guard let meta = _pjango_core_runtime_models_name2meta[_pjango_core_class_name] else {
            return nil
        }
        guard let records = _pjango_core_runtime_database.selectTable(meta) else {
            return nil
        }
        return records.map { record in
            var record = record
            record.removeFirst()
            let model = self.init()
            for i in 0..<record.count {
                model._pjango_core_fields_value[model._pjango_core_fields_key[i]] = record[i]
            }
            return model
        }
    }
    
    required public init() {
        let mirror = Mirror(reflecting: self)
        mirror.children.forEach { _, value in
            if let field = value as? PCDataBaseField {
                _pjango_core_fields.append(field)
                _pjango_core_fields_key.append(field.name)
            }
        }
    }
    
    public func toViewParam() -> PCViewParam {
        return _pjango_core_fields_value
    }

    
}

