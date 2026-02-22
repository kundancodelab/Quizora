//
//  TextFields.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
class AppTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        font = .poppinsRegular(15)
        textColor = AppColors.textPrimary
        autocorrectionType = .no
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
