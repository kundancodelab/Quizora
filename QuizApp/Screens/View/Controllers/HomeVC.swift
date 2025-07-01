import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mainViewTab: UIView!
    @IBOutlet weak var textField: UITextField!
    let defaults = UserDefaults.standard
    private var progressView: CircularProgressView!

    var initialViewPosition: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Save the initial position of the view
        initialViewPosition = self.view.frame.origin.y
        // Add tap gesture to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.mainViewTab.addGestureRecognizer(tapGesture)
            
     }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Register for keyboard appearance and disappearance events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Move the view up when the keyboard appears
    @objc func keyboardWillShow(notification: Notification) {
        // Get keyboard height
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            
            // Move the view up above the keyboard
            self.view.frame.origin.y = initialViewPosition - keyboardHeight
        }
    }
    
    // Reset the view's position when the keyboard hides
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = initialViewPosition
    }
    
    @IBAction func distapStartButton(_ sender: UIButton) {
        guard let textField = textField else {
                print("Error: textField is nil")
                return
            }

        if let name = textField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty {
            
            UserDefaults.standard.set(name, forKey: "name")
            print("Saved name:", name) // Debugging: See if the name is stored correctly

            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "QuizViewController") as? QuizViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Enter Your Name", message: "You cannot proceed without entering your name.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            print("Alert shown: Name was empty or whitespace") // Debugging: Track why alert is shown
        }
    }

    
    
}
