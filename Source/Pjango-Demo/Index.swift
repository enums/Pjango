//
//  Index.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/18.
//
//

import Foundation
import Pjango_Core

class IndexView: PCView {
    
    override var templateName: String {
        return "index.html"
    }
    
    override var viewParam: PCViewParam? {
        return [
            "_pjango_url_timezone": pjangoUrlReverse("time_zone"),
            "_pjango_param_time": Date.init().stringValue,
            "_pjango_param_msg": "Msg from Pjango"
        ]
    }
    
}
