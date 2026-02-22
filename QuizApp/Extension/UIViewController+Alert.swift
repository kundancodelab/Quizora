//
//  UIViewController+Alert.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import UIKit

extension UIViewController {
    
    /// Show a simple alert with a title and message
    func showAlert(
        title: String,
        message: String,
        buttonTitle: String = AppStrings.ok,
        handler: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            handler?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    /// Show a confirmation alert with OK and Cancel buttons
    func showConfirmationAlert(
        title: String,
        message: String,
        confirmTitle: String = AppStrings.ok,
        cancelTitle: String = AppStrings.cancel,
        confirmStyle: UIAlertAction.Style = .default,
        onConfirm: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        alert.addAction(UIAlertAction(title: confirmTitle, style: confirmStyle) { _ in
            onConfirm()
        })
        present(alert, animated: true)
    }
    
    /// Show an error alert (uses "Error" as default title)
    func showErrorAlert(message: String, handler: (() -> Void)? = nil) {
        showAlert(title: "Error", message: message, handler: handler)
    }
}
