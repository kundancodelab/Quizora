//
//  Endpoints.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation

enum Endpoints {
    
    // MARK: - Auth
    static let login        = "/auth/login"
    static let register     = "/auth/register"
    static let forgotPassword = "/auth/forgot-password"
    
    // MARK: - Quiz
    static let quizzes      = "/quizzes"
    static let questions    = "/questions"
    static let submitAnswer = "/answers/submit"
    
    // MARK: - User
    static let profile      = "/user/profile"
    static let leaderboard  = "/leaderboard"
}
