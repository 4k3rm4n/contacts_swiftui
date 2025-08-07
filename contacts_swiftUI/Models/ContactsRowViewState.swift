//
//  ContactsRowViewState.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import SwiftUI

struct ContactsRowViewState: Identifiable, Hashable {
    let id: UUID
    let fullNameText: String
    let secondaryInfoText: String?
    let avatar: Image
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init(contact: Contact, avatarImage: Image?) {
        id = contact.id
        fullNameText = "\(contact.firstName ?? "") \(contact.lastName ?? "")"
        if let phoneNumber = contact.phoneNumber, !phoneNumber.isEmpty {
            secondaryInfoText = phoneNumber
        } else if let email = contact.email, !email.isEmpty {
            secondaryInfoText = email
        } else {
            secondaryInfoText = nil
        }
        if let image = avatarImage {
            avatar = image
        } else {
            avatar = Image("EmptyContactImage")
        }
    }
}
