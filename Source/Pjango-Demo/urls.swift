//
//  urls.swift
//  Pjango-Demo
//
//  Created by 郑宇琦 on 2017/6/13.
//

import Foundation
import Pjango_Core

public let urlpatterns: Array<PCUrlConfig> = [
    url("hello", sayHelloWorld, "hello"),
    url("", IndexView.self, "index")
]

