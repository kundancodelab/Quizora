//
//  Config.swift
//  QuizApp
//
//  Created by User on 22/02/26.
//

import Foundation

enum Config {
    private static let infoDict: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Could not load info dictionary")
        }
        return dict
    }()
    
    static let BASE_URL: String = {
        guard let urlString = infoDict["BASE_URL"] as? String else {
            fatalError("Could not load BASE_URL")
        }
        return urlString
    }()
}
