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

func sayHelloWorld() -> RequestHandler {
    return HttpResponse("Hello Pjango!")
}
