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
    
    override var templateName: String {
        return "template_head.html"
    }
    
}

class TemplateFoot: PCView {
    
    override var templateName: String {
        return "template_foot.html"
    }

}

class IndexView: PCView {
    
    override var templateName: String {
        return "index.html"
    }
    
    override var objects: PCViewParam? {
        return [
            "_pjango_templage_head": TemplateHead.init().getTemplate(),
            "_pjango_templage_foot": TemplateFoot.init().getTemplate(),
            "_pjango_url_timezone": reverse("time_zone"),
            "_pjango_param_time": Date.init().stringValue,
            "_pjango_param_msg": "Msg from Pjango"
        ]
    }
    
    
}

class TimeZoneView: PCListView {
    
    override var templateName: String {
        return "time_zone.html"
    }
    
    override var querySetContextName: String {
        return "_pjango_param_timezone"
    }
    
    override var querySet: Array<PCViewable> {
        return TimeZoneModel.queryObjects() ?? []
    }
    
    override var objects: PCViewParam? {
        return [
            "_pjango_templage_head": TemplateHead.init().getTemplate(),
            "_pjango_templage_foot": TemplateFoot.init().getTemplate(),
        ]
    }

}
