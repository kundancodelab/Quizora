//
//  Validator.swift
//  QuizApp
//
//  Created by User on 26/01/26.
//

import Foundation

enum Validator {
    
    /// Returns nil if valid, or an error message string if invalid
    static func isValidEmail(_ email: String) -> String? {
        let trimmed = email.trimmed
        guard !trimmed.isEmpty else {
            return "Email cannot be empty"
        }
        guard trimmed.isValidEmail else {
            return "Please enter a valid email address"
        }
        return nil
    }
    
    static func isValidPassword(_ password: String, minLength: Int = 6) -> String? {
        guard !password.isEmpty else {
            return "Password cannot be empty"
        }
        guard password.count >= minLength else {
            return "Password must be at least \(minLength) characters"
        }
        return nil
    }
    
    static func isNotEmpty(_ text: String?, fieldName: String = "Field") -> String? {
        guard let text = text, !text.trimmed.isEmpty else {
            return "\(fieldName) cannot be empty"
        }
        return nil
    }
    
    static func isValidPhone(_ phone: String) -> String? {
        let trimmed = phone.trimmed
        guard !trimmed.isEmpty else {
            return "Phone number cannot be empty"
        }
        let phoneRegex = "^[0-9]{10,15}$"
        guard NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: trimmed) else {
            return "Please enter a valid phone number"
        }
        return nil
    }
    
    static func doPasswordsMatch(_ password: String, _ confirmPassword: String) -> String? {
        guard password == confirmPassword else {
            return "Passwords do not match"
        }
        return nil
    }
}
