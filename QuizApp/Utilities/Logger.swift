//
//  Logger.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation

enum LogLevel: String {
    case info    = "ℹ️ INFO"
    case warning = "⚠️ WARNING"
    case error   = "❌ ERROR"
    case debug   = "🐛 DEBUG"
}

final class Logger {
    
    /// Set to false to disable all logging in production
    static var isEnabled: Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    // MARK: - Convenience Methods
    
    static func info(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(level: .info, message: message, file: file, line: line, function: function)
    }
    
    static func warning(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(level: .warning, message: message, file: file, line: line, function: function)
    }
    
    static func error(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(level: .error, message: message, file: file, line: line, function: function)
    }
    
    static func debug(_ message: String, file: String = #file, line: Int = #line, function: String = #function) {
        log(level: .debug, message: message, file: file, line: line, function: function)
    }
    
    // MARK: - Core
    
    private static func log(level: LogLevel, message: String, file: String, line: Int, function: String) {
        guard isEnabled else { return }
        let fileName = (file as NSString).lastPathComponent
        print("\(level.rawValue) [\(fileName):\(line)] \(function) → \(message)")
    }
}
