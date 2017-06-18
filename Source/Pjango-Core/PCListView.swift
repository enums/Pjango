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
        if querySetContextName != "" {
            param[querySetContextName] = objs.map { $0.toViewParam() }
        }
        return param
    }
    
    open var querySetContextName: String {
        return ""
    }
    
    open var querySet: Array<PCViewable>? {
        return nil
    }
}
