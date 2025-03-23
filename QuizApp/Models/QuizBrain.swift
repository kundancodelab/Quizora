struct QuizBrain {
    
    let totalNumberOfQuestion:Int = 10 
    let swiftMCQs: [[String: Any]] = [
        [
            "question": "Who developed the Swift programming language in 2014?",
            "options": [
                "1. Microsoft",
                "2. Apple Inc.",
                "3. Google",
                "4. IBM"
            ],
            "answer": 2
        ],
        [
            "question": "What is the file extension for Swift files?",
            "options": [
                "1. .java",
                "2. .py",
                "3. .swift",
                "4. .cpp"
            ],
            "answer": 3
        ],
        [
            "question": "What is a common way to handle errors in Swift?",
            "options": [
                "1. try-catch",
                "2. error handling blocks",
                "3. do-try-catch",
                "4. None of the above"
            ],
            "answer": 3
        ],
        [
            "question": "Which keyword is used to declare a constant in Swift?",
            "options": [
                "1. let",
                "2. const",
                "3. var",
                "4. static"
            ],
            "answer": 1
        ],
        [
            "question": "What does the 'guard' keyword do in Swift?",
            "options": [
                "1. Exits the current scope if a condition is met",
                "2. Allows iteration over collections",
                "3. Declares variables",
                "4. None of the above"
            ],
            "answer": 1
        ],
        [
            "question": "What type does the 'Int.random(in: 1...10)' function return?",
            "options": [
                "1. Float",
                "2. Int",
                "3. Double",
                "4. Bool"
            ],
            "answer": 2
        ],
        [
            "question": "Which of the following is not a Swift collection type?",
            "options": [
                "1. Array",
                "2. Set",
                "3. Queue",
                "4. Dictionary"
            ],
            "answer": 3
        ],
        [
            "question": "Which of the following is a correct way to unwrap an optional in Swift?",
            "options": [
                "1. Using the '!' operator",
                "2. Using 'if let' syntax",
                "3. Using 'guard let' syntax",
                "4. All of the above"
            ],
            "answer": 4
        ],
        [
            "question": "What does the 'nil' keyword represent in Swift?",
            "options": [
                "1. A non-optional value",
                "2. A reference to an initialized object",
                "3. The absence of a value",
                "4. A syntax error"
            ],
            "answer": 3
        ],
        [
            "question": "Which keyword is used to make a function throw an error?",
            "options": [
                "1. try",
                "2. throws",
                "3. error",
                "4. catch"
            ],
            "answer": 2
        ]
        // Add more questions following this format
    ]
    
    var questionNumber = 0
    var userAnswers: [Bool] = [] // To track correct/incorrect answers
    
    func checkAnswer(selectedOptionIndex: Int) -> Bool {
        
        print(questionNumber)
        if let correctAnswer = swiftMCQs[questionNumber]["answer"] as? Int {
            print(correctAnswer)
               return selectedOptionIndex   == correctAnswer
           }
           return false
    }
    
    func getQuestionText() -> [String] {
        // Retrieve the question
        guard let question = swiftMCQs[questionNumber]["question"] as? String else {
            return ["No question available"]
        }
        
        // Retrieve the options
        guard let options = swiftMCQs[questionNumber]["options"] as? [String] else {
            return ["No options available"]
        }
        
        // Combine the question and options into a single array
        var questionWithOptions = [question]
        questionWithOptions.append(contentsOf: options)
        
        return questionWithOptions
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(swiftMCQs.count)
    }
    
    mutating func nextQuestion() {
        if questionNumber + 1 < swiftMCQs.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    func getQuestionNumber() -> Int {
        return questionNumber + 1
    }
    
    func getCorrectAnswer() -> String {
        if let correctAnswerIndex = swiftMCQs[questionNumber]["answer"] as? Int {
            guard let options = swiftMCQs[questionNumber]["options"] as? [String] else {
                return "No options available"
            }
            return options[correctAnswerIndex - 1] // Index is stored starting from 1, so we subtract 1
        }
        return "No correct answer available"
    }
    
    func getScore() -> Int {
        return userAnswers.filter { $0 }.count // Count of correct answers (true = correct)
    }
}
