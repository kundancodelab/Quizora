//
//  LoginVC.swift
//  QuizApp
//
//  Created by User on 26/01/26.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    var authViewModel = AuthViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapLoginBtn(_ sender: UIButton) {
        guard let email = emailTxtField.text else {
             return
        }
        
        guard let password = passwordTxtField.text else {
            return
        }
        
        authViewModel.signInWithEmail(email: email, password: password)
    }
    
    @IBAction func didTapGoogleLoginTap(_ sender : UIButton) {
       
        Task {
            // 1. AWAIT: Code PAUSES here until Google replies
            await authViewModel.signInWithGoogle()
            
            // 2. Code RESUMES here only after the result is ready
            if authViewModel.didGoogleLoginSuccess {
                // Now this will be true!
                // navigateToNextScreen()
                print("!!! Google  Login successfully !!!")
            } else {
                print("Login failed: \(authViewModel.errorMessage)")
            }
        }
        
    }
    
    @IBAction func didTapAppleLoginTap(_ sender: UIButon) {
        /// call signin apple 
        authViewModel.signInWithApple()
    }

}
