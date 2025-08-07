//
//  AddContactPageViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 07.07.2025.
//

import Foundation
import SwiftUI


class AddContactPageViewModelImpl: AddContactPageViewModel {
    
    @Published var contact: Contact
    let pageMode: Mode
    private var localStorageService: LocalStorageService = LocalStorageService()
    private var imageService: ImageService = ImageService()
    
    init(pageMode: Mode) {
        switch pageMode {
        case .createContactMode:
            self.contact = Contact()
        case .editContactMode(contact: let contact):
            self.contact = contact
        }
        self.pageMode = pageMode
    }
    
    func saveContact() {
        switch pageMode {
        case .createContactMode:
            do {
                try localStorageService.saveContact(with: contact)
            } catch let error {
                print(error.localizedDescription)
            }
        case .editContactMode:
            do {
                try localStorageService.removeContact(with: contact.id)
                try localStorageService.saveContact(with: contact)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func saveImage(image: UIImage?) {
        guard let image = image else { return }
        contact.imageName = imageService.saveImageToDocumentsDirectory(with: image, contactUUID: contact.id)
    }
}

