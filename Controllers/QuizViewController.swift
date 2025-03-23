import UIKit

class QuizViewController: UIViewController {
    
    let circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOption1: UIView!
    @IBOutlet weak var answerOption2: UIView!
    @IBOutlet weak var answerOption3: UIView!
    @IBOutlet weak var answerOption4: UIView!
    @IBOutlet weak var answerImage: UIImageView!
    
    @IBOutlet weak var QuizQuestion: UILabel!
    
    
    // Outlets for optional Label.
    @IBOutlet weak var option1Label: UILabel!
    
    @IBOutlet weak var option2Label: UILabel!
    
    @IBOutlet weak var option3Label: UILabel!
    
    
    @IBOutlet weak var option4Label: UILabel!
    
    @IBOutlet weak var NextButton: UIButton!
    
    var score: Int = 0
    
    var quiz = QuizBrain()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        setupCircularProgressView()
        circularProgressView.startCountdown(duration: 30)
               addTapGesture(to: answerOption1)
               addTapGesture(to: answerOption2)
               addTapGesture(to: answerOption3)
               addTapGesture(to: answerOption4)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let questionAndOptions = quiz.getQuestionText()
 
        print(questionAndOptions[0]) // Prints the question
        print(questionAndOptions[1]) // Prints the first option
        print(questionAndOptions[2]) // Prints the second option
        
        
        QuizQuestion.text = questionAndOptions[0]
        option1Label.text = questionAndOptions[1]
        option2Label.text = questionAndOptions[2]
        option3Label.text = questionAndOptions[3]
        
        option4Label.text = questionAndOptions[4]
        
       // quiz.questionNumber += 1
        questionLabel.text = String(quiz.questionNumber) + "/10"
        
        
        
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
            guard let selectedOption = sender.view else { return }

            resetOptions()  // Reset all options first
            selectedOption.backgroundColor = UIColor(red: 0.67, green: 0.82, blue: 0.78, alpha: 1.00)
            
            // Get the selected answer option index (assuming option 1 is 0, option 2 is 1, etc.)
        
            let selectedOptionIndex = getSelectedOptionIndex(for: selectedOption)

            // Check the answer
        let isCorrect = quiz.checkAnswer(selectedOptionIndex: selectedOptionIndex)
            
            // Store the result in the quiz brain
            quiz.userAnswers.append(isCorrect)
            
            // Update the score
            score = quiz.getScore()
            
            // Optionally, show the result (you can modify this as per your UI)
            if isCorrect {
                print("Correct!")
            } else {
                print("Incorrect!")
            }
        // Apply the desired behavior to the selected option
              // selectedOption.backgroundColor = UIColor(red: 0.67, green: 0.82, blue: 0.78, alpha: 1.00)

               // Find the UIImageView within the stack view
               if let stackView = selectedOption.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
                   if let imageView = stackView.arrangedSubviews.first(where: { $0 is UIImageView }) as? UIImageView {
                       imageView.image = UIImage(named: "selectedButton")
                       print("Image updated successfully in stack view.")
                   }
               }
           }
        
        
        
    
    private func getSelectedOptionIndex(for selectedOption: UIView) -> Int {
            if selectedOption == answerOption1 {
                return 1
            } else if selectedOption == answerOption2 {
                return 2
            } else if selectedOption == answerOption3 {
                return 3
            } else if selectedOption == answerOption4 {
                return 4
            }
            return 0
        }
        
    
    private func resetOptions() {
        
        // Reset background color and image for all options
        let options = [answerOption1, answerOption2, answerOption3, answerOption4]
        for option in options {
            option?.backgroundColor = UIColor.white // Reset to default background color

            // Find the UIImageView within the stack view
            if let stackView = option?.subviews.first(where: { $0 is UIStackView }) as? UIStackView {
                if let imageView = stackView.arrangedSubviews.first(where: { $0 is UIImageView }) as? UIImageView {
                    imageView.image = UIImage(named: "unselectedButton") // Reset the image
                }
            }
        }
    }


    
    private func setupCircularProgressView() {
        circularProgressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circularProgressView)
        
        NSLayoutConstraint.activate([
            // Place it below the questionLabel with a vertical gap of 31 points
            circularProgressView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 24),
            
            // Center it horizontally in the view
            circularProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Set the height of the progress view to 86 points
            circularProgressView.heightAnchor.constraint(equalToConstant: 86),
            
            // Set the width to match the height to make it circular
            circularProgressView.widthAnchor.constraint(equalTo: circularProgressView.heightAnchor)
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
   
    
    
    
    @IBAction func goToNextQuestion(_ sender: UIButton) {
        
       
//        answerOption1.setNeedsDisplay()
//        answerOption2.setNeedsDisplay()
//        answerOption3.setNeedsDisplay()
//        answerOption4.setNeedsDisplay()
//
        quiz.nextQuestion()
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        resetOptions()
        clearOverlays()
        // Restart the countdown timer
            circularProgressView.stopAnimation()
           // circularProgressView.resetCountdown()
            circularProgressView.startCountdown(duration: 30)
        
        if quiz.questionNumber == 9 {
            circularProgressView.stopAnimation()
            
            NextButton.titleLabel?.text = "Submit"
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScoreTableController") as? ScoreTableViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
            
        }
    
        
        let questionAndOptions = quiz.getQuestionText()
        
       
        
        QuizQuestion.text = questionAndOptions[0]
        option1Label.text = questionAndOptions[1]
        option2Label.text = questionAndOptions[2]
        option3Label.text = questionAndOptions[3]
        option4Label.text = questionAndOptions[4]
       
        
        questionLabel.text = String(quiz.questionNumber) + "/10"
        
        // Finally we are displaying the score that the use has got.
        if  quiz.questionNumber+1  == 10 {
            print("Score: \(score)")
        }
        
    }
 
    
}
