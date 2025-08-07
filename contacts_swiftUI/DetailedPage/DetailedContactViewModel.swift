//
//  DetailedContactViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 05.07.2025.
//

import Foundation
import Combine


class DetailedContactViewModelImpl: DetailedContactViewModel {
    
    @Published var contact: Contact
    @Published var generalInfoSectionViewStates: [DetailedContactRowView.ViewState] = []
    @Published var drivingLicenseSectionViewState: DetailedContactRowView.ViewState?
    @Published var notesSectionViewState: DetailedContactRowView.ViewState?
    
    private var localStorageService: LocalStorageService = LocalStorageService()
    private var imageService: ImageServiceProtocol = ImageService()
    private let userDefaultsStorage = UserDefaultStorage.shared
    private var cancellables: Set<AnyCancellable> = []
    
    init(contactId: UUID) {
        if let contact = localStorageService.getContact(by: contactId) {
            self.contact = contact
        } else {
            self.contact = Contact()
        }
        setupSectionsViewStates()
        setupBindings()
    }
    
    func getHeaderViewState() -> DetailContactHeaderView.ViewState {
        DetailContactHeaderView.ViewState(firstName: contact.firstName, lastName: contact.lastName, avatarImage: imageService.makeImage(from: contact.imageName))
    }
}



private extension DetailedContactViewModelImpl {
    func setupBindings() {
        userDefaultsStorage
            .$contacts
            .compactMap {
                $0.first { [weak self] in
                    $0.id == self?.contact.id
                }
            }
            .sink { [weak self] in
                self?.contact = $0
                self?.refreshSectionViewStates()
            }
            .store(in: &cancellables)
    }
    
    func refreshSectionViewStates() {
        generalInfoSectionViewStates = []
        drivingLicenseSectionViewState = nil
        notesSectionViewState = nil
        setupSectionsViewStates()
    }
    
    func setupSectionsViewStates() {
        if let phoneNumber = contact.phoneNumber {
            generalInfoSectionViewStates.append(.init(fieldName: "Phone number", infoText: phoneNumber))
        }
        
        if let email = contact.email {
            generalInfoSectionViewStates.append(.init(fieldName: "Email", infoText: email))
        }
        
        if let birthday = contact.birthday {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let stringBirthday = formatter.string(from: birthday)
            generalInfoSectionViewStates.append(.init(fieldName: "Birthday", infoText: stringBirthday))
        }
        
        if let height = contact.height {
            generalInfoSectionViewStates.append(.init(fieldName: "Height", infoText: String(height) + " cm"))
        }
        
        if let drivingLicence = contact.drivingLicenseNumber {
            drivingLicenseSectionViewState = .init(fieldName: "Driving license", infoText: drivingLicence)
        }
        
        if let notes = contact.notes {
            notesSectionViewState = .init(fieldName: "Notes", infoText: notes)
        }
    }
}
