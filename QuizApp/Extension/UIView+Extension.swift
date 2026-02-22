//
//  UIView+Extension.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import UIKit

extension UIView {
    
    /// Add multiple subviews at once
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    
    /// Pin all edges to superview with optional padding
    func pinToEdges(of superview: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
    }
    
    /// Pin to safe area edges
    func pinToSafeArea(of superview: UIView, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    /// Add shadow to the view
    func addShadow(color: UIColor = .black, opacity: Float = 0.1, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    /// Make the view circular
    func makeRounded() {
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
    
    /// Set corner radius
    func roundCorners(_ radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    /// Add border to the view
    func addBorder(color: UIColor = .lightGray, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
