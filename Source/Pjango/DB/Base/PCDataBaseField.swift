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
    
    internal var _pjango_core_set_model_block: (()->Void)? = nil
    
    public var value: PCModelDataBaseFieldType? {
        get {
            return model?._pjango_core_model_get_filed_data(key: name)
        }
        set {
            guard let value = newValue else {
                return
            }
            model?._pjango_core_model_set_field_data(key: name, value: value)
        }
    }
    
    public var intValue: Int {
        get {
            return value as! Int
        }
        set {
            value = newValue
        }
    }
    
    public var strValue: String {
        get {
            return value as! String
        }
        set {
            value = newValue
        }
    }
    
    public var name: String
    public var type: PCDataBaseFieldType {
        get {
            return model?._pjango_core_model_fields_type[name] ?? .unknow
        }
        set {
            model?._pjango_core_model_fields_type[name] = newValue
        }
    }
    public var length = 11
    public var notNull = false
    public var defaultValue: String?
    
    public init(name: String, type: PCDataBaseFieldType, length: Int = 11,
                value: PCModelDataBaseFieldType? = nil, notNull: Bool = false, defaultValue: String? = nil) {
        self.name = name
        _pjango_core_set_model_block = { [weak self] in
            self?.length = length
            self?.value = value
            self?.type = type
            self?.notNull = notNull
            self?.defaultValue = defaultValue
        }
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
