//
//  BaseCollectionViewCell.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    /// Override in subclasses to add subviews and configure appearance
    func setupUI() { }
    
    /// Override in subclasses to set up Auto Layout constraints
    func setupConstraints() { }
}
