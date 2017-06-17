//
//  view.swift
//  Pjango
//
//  Created by 郑宇琦 on 2017/6/13.
//
//

import Foundation
import PerfectHTTP
import Pjango_Core

class TemplateHead: PCView {
    required init() {
        super.init()
        templateName = "template_head.html"
    }
}

class TemplateFoot: PCView {
    required init() {
        super.init()
        templateName = "template_foot.html"
    }
}

class IndexView: PCView {
    
    override var objects: PCViewParam? {
        return [
            "_pjango_templage_head": TemplateHead.init().getTemplate(),
            "_pjango_templage_foot": TemplateFoot.init().getTemplate(),
            "_pjango_url_list": reverse(""),
            "_pjango_param_time": Date.init().stringValue,
            "_pjango_param_msg": "Msg from Pjango"
        ]
    }
    
    required init() {
        super.init()
        
        templateName = "index.html"
        
    }
    
}

class TimeZoneView: PCView {
    
    override var objects: PCViewParam? {
        let date = Date.init()
        let dates = [
            TimeZoneDate.init(date: date, zone: "GMT"),
            TimeZoneDate.init(date: date, zone: "UTC"),
            TimeZoneDate.init(date: date, zone: "CST"),
        ]
        return [
            "_pjango_templage_head": TemplateHead.init().getTemplate(),
            "_pjango_templage_foot": TemplateFoot.init().getTemplate(),
            "_pjango_param_loop_timezone": dates.map { $0.toViewParam() }
        ]
    }

    required init() {
        super.init()
        templateName = "time_zone.html"
    }
}
