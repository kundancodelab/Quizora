//
//  BookVM.swift
//  TestMVVMProject
//
//  Created by User on 06/04/25.
//

import Foundation
class QuestionVM {
    static var trackQuestionNumber = -1
    var quizQuestions:[questionModel] = []
    var eventHandler : ((_ event:Event) -> Void)?  // Data Binding closure
    var numberOfQuestions: Int {
        print(quizQuestions.count)
            return quizQuestions.count
        }
        
        func question() -> String {
            if   QuestionVM.trackQuestionNumber+1 >= numberOfQuestions {
                QuestionVM.trackQuestionNumber = -1 // Reset to first question (or handle end of quiz)
            }
            QuestionVM.trackQuestionNumber += 1
            return quizQuestions[QuestionVM.trackQuestionNumber].question
        }
        
        func options(at index: Int) -> [String] {
            return quizQuestions[index].options
        }
        
        func answer(at index: Int) -> String {
            return quizQuestions[index].answer
        }
        
        func explanation(at index: Int) -> String {
            return quizQuestions[index].explanation
        }
    func fetchData() {
        self.eventHandler?(.loading)
        APIManager.shared.fetchQuestionsData(completion:) { [weak self] result in
            self?.eventHandler?(.stopLoading)
            switch result {
            case .success(let questions):
                self?.quizQuestions = questions
                self?.eventHandler?(.dataLoaded)
            case .failure(let error):
                self?.eventHandler?(.error(error))
            }
        }
    }
}

extension QuestionVM {
    enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(Error?)
    }
}
