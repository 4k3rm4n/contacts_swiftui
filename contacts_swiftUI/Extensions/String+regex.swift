//
//  String+regex.swift
//  contacts
//
//  Created by Bogdan on 20.05.2025.
//

import Foundation

extension String {
    
    func isMatch(regex: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            assertionFailure("Wrong regex format")
            return false
        }
        let range = NSRange(location: 0, length: utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
