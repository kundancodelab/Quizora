//
//  AppUtils.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
final class AppUtils {
    static func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    static func vibrate() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
}
