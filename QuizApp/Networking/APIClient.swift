//
//  APIClient.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation

enum HttpsMethod: String {
    case get, post, put, delete
}

class APIClient {
    static let shared = APIClient()
    static let baseURL = Config.BASE_URL
    private init() { }
    
    func request<T: Decodable>(
        urlString: String,
        token: String? = nil,
        method: HttpsMethod = .get,
        body: Data? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: Self.baseURL + urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
