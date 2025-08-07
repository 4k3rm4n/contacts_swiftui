//
//  RegexErrors.swift
//  contacts
//
//  Created by Bogdan on 20.05.2025.
//

import Foundation

enum RegexErrors: Error, LocalizedError {
    case maxCharactersExceeded
    case onlySpaceCharacters
    case emailFormatError
    case phoneNumberFormatError
    
    var errorDescription: String? {
        switch self {
        case .maxCharactersExceeded:
            return "Max 20 characters"
        case .onlySpaceCharacters:
            return "Enter 0 - 20 characters (not space bars only)"
        case .emailFormatError:
            return "Enter email in format: name@example.com"
        case .phoneNumberFormatError:
            return "Phone number format: “+12124567890” "
        }
    }
}

enum RegexPattern {
    static let maxCharactersPattern = "^.{0,20}$"
    static let onlySpaceCharactersPattern = "^(?![ ]+$).{0,20}$"
    static let phoneNumberFormatPattern = "^$|^\\+380\\d{9}$"
    static let emailFormatPattern = "^$|^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
}
