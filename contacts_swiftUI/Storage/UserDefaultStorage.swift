//
//  UserDefaultsStorage.swift
//  contacts
//
//  Created by Bogdan on 10.06.2025.
//

import Foundation

class UserDefaultStorage {
    static let shared = UserDefaultStorage()
    
    private init() {}
    
    @UserDefault(key: .contacts, defaultValue: [])
    var contacts: [Contact]
    
//    @UserDefault(key: .settings, defaultValue: Settings(displayOrder: .lastFirst, infoView: .detailed))
//    var settings: Settings
}
