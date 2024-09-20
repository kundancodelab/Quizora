//
//  Questions.swift
//  QuizApp
//
//  Created by Kundan ios dev  on 07/08/24.
//

//
//  Questions.swift
//  Quizzler-iOS13
//
//  Created by Kundan ios dev  on 15/06/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    var text:String
    var answer:String
    
    init(q: String, a: String) {
        self.text = q
        self.answer = a
    }
}

