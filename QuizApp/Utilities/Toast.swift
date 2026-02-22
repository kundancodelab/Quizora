//
//  Toast.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
// Reuslable toast  reusable : Toast.show(message: "Saved Successfully", in: self.view) 
final class Toast {
    static func show(
        message: String,
        in view: UIView,
        duration: TimeInterval = 2.0
    ) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.font = .poppinsRegular(14)
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        let padding: CGFloat = 16
        let maxWidth = view.frame.width - 40
        let size = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: .greatestFiniteMagnitude))
        toastLabel.frame = CGRect(
            x: (view.frame.width - size.width - padding) / 2,
            y: view.frame.height - 120,
            width: size.width + padding,
            height: size.height + padding
        )
        view.addSubview(toastLabel)
        toastLabel.alpha = 0
        UIView.animate(withDuration: 0.3) {
            toastLabel.alpha = 1
        }
        UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut) {
            toastLabel.alpha = 0
        } completion: { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
