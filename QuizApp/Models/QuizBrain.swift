//
//  QuizBrain.swift
//  QuizApp
//
//  Created by Kundan ios dev  on 07/08/24.
//

//
//  QuizBrain.swift
//  Quizzler-iOS13
//
//  Created by Kundan ios dev  on 16/06/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation


struct QuizBrain {
    
    let mcqQuestions: [Question] = [
        Question(q: "Swift is a statically typed programming language.", a: "True"),
        Question(q: "In Swift, optionals can be nil without causing a runtime error.", a: "True"),
        Question(q: "Swift uses Automatic Reference Counting (ARC) for memory management.", a: "True"),
        Question(q: "The Swift standard library does not include support for arrays.", a: "False"),
        Question(q: "In Swift, structs are passed by reference.", a: "False"),
        Question(q: "Swift allows functions to be nested within other functions.", a: "True"),
        Question(q: "Swift uses the 'var' keyword to define constants.", a: "False"),
        Question(q: "You can use 'guard' statements for early exit in Swift functions.", a: "True"),
        Question(q: "Swift enums can have associated values.", a: "True"),
        Question(q: "In Swift, 'let' is used to declare mutable variables.", a: "False"),
        Question(q: "Protocols in Swift can have optional requirements.", a: "True"),
        Question(q: "Swift's 'if let' syntax is used for optional binding.", a: "True"),
        Question(q: "Swift does not support operator overloading.", a: "False"),
        Question(q: "The 'defer' keyword in Swift is used to execute a code block just before the current scope exits.", a: "True"),
        Question(q: "Swift supports both reference types and value types.", a: "True"),
        Question(q: "In Swift, 'self' refers to the current instance of a class or struct.", a: "True"),
        Question(q: "Swift does not support type inference.", a: "False"),
        Question(q: "Swift can interoperate with Objective-C code.", a: "True"),
        Question(q: "The 'try' keyword in Swift is used for error handling.", a: "True"),
        Question(q: "In Swift, extensions can add new functionality to an existing class, struct, or protocol.", a: "True"),
        Question(q: "Swift does not allow computed properties in structs.", a: "False"),
        Question(q: "The 'weak' keyword in Swift is used to avoid strong reference cycles.", a: "True"),
        Question(q: "You can use 'map', 'filter', and 'reduce' functions with Swift arrays.", a: "True"),
        Question(q: "Swift playgrounds are used for testing and learning Swift code in a live environment.", a: "True"),
        Question(q: "Swift requires semicolons at the end of each statement.", a: "False"),
        Question(q: "The 'lazy' keyword in Swift is used to delay initialization of a property until it's first used.", a: "True"),
        Question(q: "In Swift, closures are self-contained blocks of functionality that can be passed around and used in your code.", a: "True"),
        Question(q: "Swift does not allow multiple inheritance for classes.", a: "True"),
        Question(q: "Swift provides a unified interface for working with both mutable and immutable collections.", a: "True"),
        Question(q: "Objective-C is the parent language of Swift.", a: "True")
    ]
    var questionNumber = 0
    
    func checkAnsewr(_ answer:String) -> Bool {
        if answer == mcqQuestions[questionNumber].answer {
            return true // user got it right
        }else{
            return false // user got it wrong
        }
    }
    
    func getQuestionText() -> String {
        
        return mcqQuestions[questionNumber].text
    }
    
    func getProgress() -> Float {
        
        return Float(questionNumber) / Float(mcqQuestions.count)
        
    }
    
    
    mutating func nextQuestion(){
        if questionNumber + 1 < mcqQuestions.count {
            questionNumber += 1
        }else{
            questionNumber = 0
        }
    }
    
    func getQuestionNumber() -> Int  {
        return questionNumber + 1
    }
    

    
}

