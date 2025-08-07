//
//  LocalStorageService.swift
//  contacts
//
//  Created by Bogdan on 09.06.2025.
//

import Foundation

protocol LocalStorageServiceProtocol {
    func saveContact(with contact: Contact) throws
    func removeContact(with id: UUID) throws
    func getContact(by id: UUID) -> Contact?
}

struct LocalStorageService: LocalStorageServiceProtocol {
    
    private let userDefaultsStorage = UserDefaultStorage.shared
    
    func saveContact(with contact: Contact) throws {
        var contacts = userDefaultsStorage.contacts
        contacts.insert(contact, at: .zero)
        
        userDefaultsStorage.contacts = contacts
    }
    
    func removeContact(with id: UUID) throws {
        var contacts = userDefaultsStorage.contacts
        contacts.removeAll { $0.id == id }
        
        userDefaultsStorage.contacts = contacts
    }
    
    func getContact(by id: UUID) -> Contact? {
        userDefaultsStorage.contacts.first(where: {$0.id == id})
    }
}
