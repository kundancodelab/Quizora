import UIKit
import MBProgressHUD
class QuizViewController: UIViewController {
    
   private let viewModel = QuestionVM()
    private var currentQuestionIndex = 0
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
   // var quiz = QuizBrain()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircularProgressView()
        circularProgressView.startCountdown(duration: 30)
               addTapGesture(to: answerOption1)
               addTapGesture(to: answerOption2)
               addTapGesture(to: answerOption3)
               addTapGesture(to: answerOption4)
        configure()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    private func addTapGesture(to view: UIView) {
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleAnswerSelection(_:)))
           view.addGestureRecognizer(tapGesture)
           view.isUserInteractionEnabled = true
       }
    
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        // Reset background color and image for all options for reseting the options.
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
        removeOverlay(from: view)
        // Create and configure the overlay
        let overlay = UIView(frame: view.bounds)
        overlay.backgroundColor = UIColor.darkGray
        overlay.alpha = 0.5 // Adjust alpha if needed
        overlay.layer.cornerRadius = view.frame.size.width / 2
        overlay.clipsToBounds = true
        // Add the checkmark image
        let checkmarkImageView = UIImageView(image: UIImage(named: "checkmark.png"))
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
        for subview in view.subviews {
            if subview.backgroundColor == UIColor.darkGray || subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
    }
   
    @IBAction func goToNextQuestion(_ sender: UIButton) {
        updateUI()
    }
   
}
extension QuizViewController{
    // Updating the UI.
    private func updateUI() {
        if viewModel.quizQuestions.count == 0 {
            print("Quiz questino is empty!")
        }
        guard viewModel.numberOfQuestions > 0 else {
            questionLabel.text = "No questions available"
            NextButton.isEnabled = false
            return
        }
       
        let rawQuestion = viewModel.question()
        let cleanedQuestion = rawQuestion.replacingOccurrences(of: "\\s*\\(Q\\d+\\)", with: "", options: .regularExpression)
        QuizQuestion.text = cleanedQuestion
        self.questionLabel.text = "\((QuestionVM.trackQuestionNumber)+1) / \(viewModel.numberOfQuestions)"
        // Disable Next button if on the last question
        NextButton.isEnabled = currentQuestionIndex < viewModel.numberOfQuestions - 1
    }
    @objc func handleAnswerSelection(_ sender: UITapGestureRecognizer) {
        guard let selectedOption = sender.view else { return }
        let selectedIndex = getSelectedOptionIndex(for: selectedOption) - 1 // 0-based index
        let correctAnswerLetter = viewModel.answer(at: currentQuestionIndex)
        guard let firstChar = correctAnswerLetter.first,
                  let asciiValue = firstChar.asciiValue,
                  asciiValue >= 97 && asciiValue <= 100 else { // Ensure it's "a" to "d"
                print("Invalid answer letter: \(correctAnswerLetter)")
                return
            }
        let correctIndex = Int(asciiValue - 97)
        // Here, checking the anser correct or not.
        if selectedIndex == correctIndex {
            score += 1
            addOverlay(to: selectedOption)
        } else {
           
        }
    }
}
extension QuizViewController{
    func configure(){
        initViewModel()
        eventObserver()
    }
    func initViewModel(){
        viewModel.fetchData()
    }
    func eventObserver(){
        self.showHUD(progressLabel: "Loading...")
        viewModel.eventHandler  = { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .loading:
                print("Product Loading...")
            case .stopLoading:
                print("Stop Loading...")
            case .dataLoaded:
                print("Data loaded...")
                self.dismissHUD(isAnimated: true)
                print(viewModel.quizQuestions)
                DispatchQueue.main.async {
                    self.updateUI()
                }
            case .error(let error):
                print(error ?? "Error" )
            }
        }
    }
}
