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

class IndexView: PCView {
    
    required init() {
        super.init()
        
        
        
        template_name = "index.html"
        
        
    }
    
}
