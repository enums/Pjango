//
//  PCDataBaseField.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

public enum PCDataBaseFieldType: String {
    case unknow = ""
    case string = "VARCHAR"
    case int = "INT"
}
public protocol PCModelDataBaseFieldType { }
extension String: PCModelDataBaseFieldType { }
extension Int: PCModelDataBaseFieldType { }


final public class PCDataBaseField {
    
    public weak var model: PCModel? = nil
    
    public var value: PCModelDataBaseFieldType? {
        get {
            return model?._pjango_core_model_fields_value[name]
        }
        set {
            model?._pjango_core_model_fields_value[name] = newValue
        }
    }
    
    public var name: String
    public var type: PCDataBaseFieldType {
        get {
            switch value {
            case is String?: return .string
            case is Int?: return .int
            default: return .unknow
            }
        }
        set {
            switch newValue {
            case .unknow: value = nil
            case .string: value = ""
            case .int: value = 0
            }
        }
    }
    public var length: Int
    public var notNull = false
    public var defaultValue: String?
    
    public init(name: String, type: PCDataBaseFieldType = .unknow, length: Int = 11,
                value: PCModelDataBaseFieldType? = nil, notNull: Bool = false, defaultValue: String? = nil) {
        self.name = name
        self.length = length
        self.value = value
        self.type = type
        self.notNull = notNull
        self.defaultValue = defaultValue
    }
    
    
    internal func _pjango_core_toSql() -> PCSqlStatement {
        let typeStr = "\(type.rawValue)(\(length))"
        let nullStr: String
        if notNull, let defaultValue = self.defaultValue {
            nullStr = "NOT NULL DEFAULT \(defaultValue)"
        } else {
            nullStr = "NULL"
        }
        return "`\(name)` \(typeStr) \(nullStr)"
    }
    

}
