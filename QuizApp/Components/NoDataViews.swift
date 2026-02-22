//
//  NoDataViews.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation
import UIKit
final class NoDataView: UIView {
    private let titleLabel = AppLabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    private func setup() {
        titleLabel.text = "No Data Found"
        titleLabel.textAlignment = .center
        titleLabel.fontStyle = .semiBold
        titleLabel.fontSize = 16
        titleLabel.textColor = AppColors.textSecondary
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}


/*
 Use in UITableView
 tableView.backgroundView = NoDataView()
 
 Or show only when empty:

 if items.isEmpty {
     tableView.backgroundView = NoDataView()
 } else {
     tableView.backgroundView = nil
 }
 
 Use in UICollectionView
 if items.isEmpty {
     collectionView.backgroundView = NoDataView()
 } else {
     collectionView.backgroundView = nil
 }
 */
