import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - UI Elements (Programmatic — no storyboard)
    private let mainViewTab = UIView()
    private let nameTextField = AppTextField()
    private let startButton = AppButton()
    private let titleLabel = AppLabel()
    private let subtitleLabel = AppLabel()
    
    let defaults = UserDefaults.standard
    
    // MARK: - BaseViewController Overrides
    
    override func setupUI() {
        title = AppStrings.appName
        
        // Title Label
        titleLabel.text = "Welcome to Quizora"
        titleLabel.fontStyle = .bold
        titleLabel.fontSize = 28
        titleLabel.textAlignment = .center
        
        // Subtitle Label
        subtitleLabel.text = "Enter your name to start the quiz"
        subtitleLabel.fontStyle = .regular
        subtitleLabel.fontSize = 16
        subtitleLabel.textColor = AppColors.textSecondary
        subtitleLabel.textAlignment = .center
        
        // Text Field
        nameTextField.placeholder = "Enter your name"
        nameTextField.returnKeyType = .done
        nameTextField.delegate = self
        
        // Start Button
        startButton.setTitle("Start Quiz", for: .normal)
        
        // Main container
        mainViewTab.backgroundColor = .clear
        mainViewTab.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        view.addSubview(mainViewTab)
        
        [titleLabel, subtitleLabel, nameTextField, startButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainViewTab.addSubview($0)
        }
        
        // Tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        mainViewTab.addGestureRecognizer(tapGesture)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            // Main container pinned to safe area
            mainViewTab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainViewTab.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainViewTab.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainViewTab.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: mainViewTab.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: mainViewTab.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: mainViewTab.trailingAnchor, constant: -24),
            
            // Subtitle
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: mainViewTab.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: mainViewTab.trailingAnchor, constant: -24),
            
            // Text Field
            nameTextField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 40),
            nameTextField.leadingAnchor.constraint(equalTo: mainViewTab.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: mainViewTab.trailingAnchor, constant: -24),
            
            // Start Button
            startButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            startButton.leadingAnchor.constraint(equalTo: mainViewTab.leadingAnchor, constant: 24),
            startButton.trailingAnchor.constraint(equalTo: mainViewTab.trailingAnchor, constant: -24),
        ])
    }
    
    override func setupActions() {
        startButton.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func didTapStartButton() {
        guard let name = nameTextField.text?.trimmed, !name.isEmpty else {
            let alert = UIAlertController(title: "Enter Your Name", message: "You cannot proceed without entering your name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: AppStrings.ok, style: .default))
            present(alert, animated: true)
            return
        }
        
        UserDefaults.standard.set(name, forKey: "name")
        print("Saved name: \(name)")
        
        // TODO: Push QuizViewController programmatically once migrated
        // let quizVC = QuizViewController()
        // navigationController?.pushViewController(quizVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didTapStartButton()
        return true
    }
}
