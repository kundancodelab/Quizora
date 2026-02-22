//
//  Labels.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
enum AppFontStyle {
    case regular
    case semiBold
    case bold
}
class AppLabel: UILabel {
    var fontStyle: AppFontStyle = .regular {
        didSet {
            applyFont()
        }
    }
    var fontSize: CGFloat = 14 {
        didSet {
            applyFont()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        textColor = AppColors.textPrimary
        numberOfLines = 0
        applyFont()
    }
    private func applyFont() {
        switch fontStyle {
        case .regular:
            font = .poppinsRegular(fontSize)
        case .semiBold:
            font = .poppinsSemiBold(fontSize)
        case .bold:
            font = .poppinsBold(fontSize)
        }
    }
}
