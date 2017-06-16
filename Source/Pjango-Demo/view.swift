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

func sayHelloWorld() -> PCUrl {
    return HttpResponse("Hello Pjango!")
}

class TemplateHead: PCView {
    required init() {
        super.init()
        template_name = "template_head.html"
    }
}

class TemplateFoot: PCView {
    required init() {
        super.init()
        template_name = "template_foot.html"
    }
}

class IndexView: PCView {
    
    override func getObjects() -> Dictionary<String, Any>? {
        return [
            "_pjango_templage_head": TemplateHead.init().getTemplate(),
            "_pjango_templage_foot": TemplateFoot.init().getTemplate(),
            "_pjango_time": Date.init().stringValue,
            "_pjango_msg": "Msg from Pjango"
        ]
    }
    
    required init() {
        super.init()
        
        template_name = "index.html"
        
        
    }
    
}
