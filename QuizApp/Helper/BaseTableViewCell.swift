//
//  BaseTableViewCell.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    func setupUI() { }
}
