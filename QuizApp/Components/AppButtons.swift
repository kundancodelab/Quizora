//
//  Buttons.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
class AppButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        layer.cornerRadius = 14
        backgroundColor = AppColors.primary
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .poppinsSemiBold(16)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
