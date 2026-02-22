import UIKit
import AVFoundation

class SpeakQuestionViewController: UIViewController {

    @IBOutlet weak var speakButton: UIButton!
    
    @IBOutlet weak var InputTextField: UITextField!
    let synthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   @IBAction func speakButtonTapped(_ sender: UIButton) {
       guard var text = InputTextField.text else {
           return
       }
        // text = "नमस्ते, यह एक उदाहरण है।" // Replace with user input
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "hi-IN") // Hindi voice
        utterance.rate = 0.5 // Set speed of speech
        synthesizer.speak(utterance)
    }
}
