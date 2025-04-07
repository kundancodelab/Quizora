//
//  String+Extension.swift
//  QuizApp
//
//  Created by User on 07/04/25.
//

import Foundation
extension String {
    // Returns ASCII code of the character at a given index (if exists).
    func asciiCode(at index: Int) -> Int? {
        guard index >= 0 && index < self.count else { return nil }
        let char = self[self.index(self.startIndex, offsetBy: index)]
        return char.asciiValue.map { Int($0) }
    }
    // Returns array of ASCII codes for the whole string.
    var asciiCodes: [Int] {
        return self.compactMap { $0.asciiValue.map { Int($0) } }
    }
}
