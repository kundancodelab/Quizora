//
//  NetworkErrors.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation

// MARK: - Error Types
enum AuthError: Error {
    case configurationError
    case invalidUserData
    case invalidCredential
    case unknownError
}

enum DatabaseError: Error {
    case userNotFound
    case updateFailed
    case deleteFailed
}

enum NetworkError: Error {
    case noInternetConnection
    case invalidResponse
    case unknownError
    case invalidURL
}
