//
//  PCListView.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/17.
//
//

import Foundation

open class PCListView: PCView {
    
    override internal var _pjango_core_view_param: PCViewParam {
        var param = super._pjango_core_view_param
        guard let objs = querySet else {
            return param
        }
        param[viewParamListName] = objs.map { (obj) -> PCViewParam in
            var param: Dictionary<String, Any> = obj.toViewParam()
            if let extParam = viewParamUserField(withModel: obj) {
                extParam.forEach { (key, value) in
                    param[key] = value
                }
            }
            return param
        }
        return param
    }
    
    open var viewParamListName: String {
        return "_pjango_param_table"
    }
    
    open func viewParamUserField(withModel model: PCModel) -> PCViewParam? {
        return nil
    }
    
    open var querySet: Array<PCModel>? {
        return nil
    }
}
