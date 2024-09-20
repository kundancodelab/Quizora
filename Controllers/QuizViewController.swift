import UIKit

class QuizViewController: UIViewController {
    let circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOption1: UIView!
    @IBOutlet weak var answerOption2: UIView!
    @IBOutlet weak var answerOption3: UIView!
    @IBOutlet weak var answerOption4: UIView!
    @IBOutlet weak var answerImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCircularProgressView()
        circularProgressView.startCountdown(duration: 30)
               addTapGesture(to: answerOption1)
               addTapGesture(to: answerOption2)
               addTapGesture(to: answerOption3)
               addTapGesture(to: answerOption4)
    }
    
    private func addTapGesture(to view: UIView) {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAnswerSelection(_:)))
           view.addGestureRecognizer(tapGesture)
           view.isUserInteractionEnabled = true
       }
    
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleAnswerSelection(_ sender: UITapGestureRecognizer) {
        
//        guard let selectedOption = sender.view else { return }
//        
//        // Assume the correct answer is option 2 for demonstration
//        let correctOption = answerOption2
//        
//        if selectedOption == correctOption {
//            addOverlay(to: selectedOption)
//        } else {
//            clearOverlays()
//        }
        answerOption1.backgroundColor = UIColor(red: 0.67, green: 0.82, blue: 0.78, alpha: 1.00)
        
        //addOverlay(to: answerOption1)
    }
    
    private func setupCircularProgressView() {
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circularProgressView)
        
        NSLayoutConstraint.activate([
            circularProgressView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 31),
            circularProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 172),
            circularProgressView.widthAnchor.constraint(equalToConstant: 86),
            circularProgressView.heightAnchor.constraint(equalToConstant: 86)
        ])
    }
    
    
    private func addOverlay(to view: UIView) {
        // Remove any existing overlay
        removeOverlay(from: view)
        
        // Create and configure the overlay
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.darkGray
        overlay.alpha = 0.5 // Adjust alpha if needed
        overlay.layer.cornerRadius = view.frame.size.width / 2
        overlay.clipsToBounds = true
        
        // Add the checkmark image
        let checkmarkImageView = UIImageView(image: UIImage(named: "checkmark.png")) // Ensure this image is added to your project
        checkmarkImageView.frame = CGRect(x: (view.bounds.size.width - 40) / 2, y: (view.bounds.size.height - 40) / 2, width: 40, height: 40)
        checkmarkImageView.contentMode = .scaleAspectFit
        
        // Add overlay and checkmark image to the view
        view.addSubview(overlay)
        view.addSubview(checkmarkImageView)
    }
    
    private func clearOverlays() {
        // Remove overlays from all options
        removeOverlay(from: answerOption1)
        removeOverlay(from: answerOption2)
        removeOverlay(from: answerOption3)
        removeOverlay(from: answerOption4)
    }
    
    private func removeOverlay(from view: UIView) {
        // Remove any existing overlay and checkmark image
        for subview in view.subviews {
            if subview.backgroundColor == UIColor.darkGray || subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
    
   
    
    
    
}
