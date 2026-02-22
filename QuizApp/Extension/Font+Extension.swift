//
//  Font+Extension.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import  UIKit
extension UIFont {
    static func poppinsRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    static func poppinsSemiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }
    static func poppinsBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
}
