//
//  AppRouter.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import UIKit

final class AppRouter {
    
    // MARK: - Shared Instance
    static let shared = AppRouter()
    private init() { }
    
    // MARK: - Window Reference
    var window: UIWindow?
    
    // MARK: - Navigation Helpers
    
    /// Push a view controller onto the current navigation stack
    static func push(_ viewController: UIViewController, from source: UIViewController, animated: Bool = true) {
        source.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    /// Present a view controller modally
    static func present(_ viewController: UIViewController, from source: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        source.present(viewController, animated: animated, completion: completion)
    }
    
    /// Pop the top view controller
    static func pop(from source: UIViewController, animated: Bool = true) {
        source.navigationController?.popViewController(animated: animated)
    }
    
    /// Pop to root view controller
    static func popToRoot(from source: UIViewController, animated: Bool = true) {
        source.navigationController?.popToRootViewController(animated: animated)
    }
    
    /// Dismiss a modally presented controller
    static func dismiss(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }
    
    // MARK: - Root VC Management
    
    /// Set a new root view controller with optional navigation wrapping
    func setRootViewController(_ viewController: UIViewController, withNavigation: Bool = true, animated: Bool = true) {
        guard let window = window else { return }
        
        let rootVC: UIViewController
        if withNavigation {
            rootVC = UINavigationController(rootViewController: viewController)
        } else {
            rootVC = viewController
        }
        
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = rootVC
            })
        } else {
            window.rootViewController = rootVC
        }
        window.makeKeyAndVisible()
    }
}
