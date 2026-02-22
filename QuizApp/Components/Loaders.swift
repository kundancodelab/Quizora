//
//  Loaders.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//


import UIKit
import MBProgressHUD
import Foundation
extension UIViewController {
    func showHUD(progressLabel:String) {
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            progressHUD.label.text = progressLabel
        }
    }
    
    func dismissHUD(isAnimated:Bool){
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}
