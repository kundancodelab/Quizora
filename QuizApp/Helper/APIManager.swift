//
//  APIManager.swift
//  QuizApp
//
//  Created by User on 07/04/25.
//

import Foundation
enum DataError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case network(Error?)
}
typealias handler = (Result<[questionModel], DataError>) -> Void

class APIManager {
    static let shared = APIManager()
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
}


