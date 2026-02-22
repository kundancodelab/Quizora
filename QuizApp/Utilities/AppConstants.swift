//
//  AppConstants.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation

/// Centralized constants for the app. Prefer this over hardcoded strings.
enum AppConstants {
    
    // MARK: - UserDefaults Keys
    enum UserDefaultsKeys {
        static let isAlreadyLoggedIn      = "IS_ALREADY_LOGGED_IN"
        static let isUserLoggedOut        = "IS_USER_LOGGED_OUT"
        static let userId                 = "USER_ID"
        static let isOnboardingCompleted  = "IS_ONBOARDING_COMPLETED"
        static let fcmToken               = "FCM_TOKEN"
        static let authToken              = "AUTH_TOKEN"
        static let isFetchedUserData      = "IS_FETCHED_USER_DATA"
        static let hasCompletedOnboarding = "HAS_COMPLETED_ONBOARDING"
        static let userEmail              = "USER_EMAIL"
        static let userPassword           = "USER_PASSWORD"
        static let selectedLanguage       = "SELECTED_LANGUAGE"
        static let isAppInstalledFirstTime = "IS_APP_INSTALLED_FIRST_TIME"
        static let userName               = "name"
    }
    
    // MARK: - Default Values
    enum Defaults {
        static let selectedLanguage = "en"
    }
    
    // MARK: - App Info
    enum AppInfo {
        static let appName = "Quizora"
        static var appVersion: String {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        }
        static var buildNumber: String {
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        }
    }
    
    // MARK: - Layout
    enum Layout {
        static let defaultPadding: CGFloat = 16
        static let defaultCornerRadius: CGFloat = 12
        static let buttonHeight: CGFloat = 50
        static let textFieldHeight: CGFloat = 48
    }
}
