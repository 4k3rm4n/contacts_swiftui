//
//  ContactsListSection.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import Foundation

struct ContactsListSection: Identifiable {
    var id = UUID()
    let headerLetter: String
    let contactRowViewStates: [ContactsRowViewState]
    
    init(headerLetter: String, ContactRowViewStates: [ContactsRowViewState]) {
        self.headerLetter = headerLetter
        self.contactRowViewStates = ContactRowViewStates
    }
}
