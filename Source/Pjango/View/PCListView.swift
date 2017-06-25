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
        guard let lists = listObjectSets else {
            return param
        }
        for (list, objs) in lists {
            param[list] = objs.map { (obj) -> PCViewParam in
                var param: Dictionary<String, Any> = obj.toViewParam()
                if let extParam = listUserField(inList: list, forModel: obj) {
                    extParam.forEach { (key, value) in
                        param[key] = value
                    }
                }
                return param
            }
        }
        return param
    }
    
    open func listUserField(inList list: String, forModel model: PCModel) -> PCViewParam? {
        return nil
    }
    
    
    open var listObjectSets: [String: [PCModel]]? {
        return nil
    }
    
}
