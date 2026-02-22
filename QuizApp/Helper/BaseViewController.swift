//
//  BaseViewController.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
        setupActions()
    }
    func setupUI() { }
    func setupConstraints() { }
    func setupActions() { }
}
