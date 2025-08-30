//
//  APIManager.swift
//  QuizApp
//
//  Created by User on 07/04/25.
//
// this is project where we are learing about solving merge conflicts. 
import Foundation
import FirebaseStorage
import FirebaseFirestore


enum DataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case network(Error?)
}
typealias handler = (Result<[questionModel], DataError>) -> Void

class APIManager {
    static let shared = APIManager()
    // MARK: Base url Live...
    let baseURL = ""
    // MARK: Base url Local...
   // let baseURL = ""
    private init() {}
    
    func fetchQuestionsData(completion: @escaping handler) {
        guard let url = URL(string:APIConstant.baseURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            
            guard let data = data , error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
         
            do {
                let finalQuestiondata = try JSONDecoder().decode([questionModel].self, from: data)
                completion(.success(finalQuestiondata))
            }catch {
                print(error.localizedDescription)
                completion(.failure(.network(error)))
            }
        }.resume()
    }
    
    func fetchQuestions(forLanguage language: String, completion: @escaping ([questionModel]) -> Void) {
        let db = Firestore.firestore()
        db.collection("quizzes").document(language).collection("questions").getDocuments { snapshot, error in
            var questions: [questionModel] = []
            if let documents = snapshot?.documents {
                for doc in documents {
                    let data = doc.data()
                    if let questionText = data["question"] as? String,
                       let options = data["options"] as? [String],
                       let correct = data["correctAnswer"] as? String {
                        let q = questionModel(question: questionText, options: options, answer: correct, explanation: "N/A")
                        questions.append(q)
                    }
                }
                completion(questions)
            }
        }
    }

}


