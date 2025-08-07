//
//  HomePageViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import Foundation
import Combine

class HomePageViewModelImpl: HomePageViewModel {
    @Published var contacts: [Contact]
    var contactsListSections: [ContactsListSection] = []
    var contactCellsViewStates: [ContactsRowViewState] {
        getContactCellsViewStates()
    }
    private var localStorageService: LocalStorageServiceProtocol = LocalStorageService()
    private var imageService: ImageService = ImageService()
    private let userDefaultsStorage = UserDefaultStorage.shared
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        contacts = userDefaultsStorage.contacts
        userDefaultsStorage
            .$contacts
            .sink { [weak self] in
                print("\($0.count)")
                self?.contacts = $0
                self?.getGroupedContactTableSections()
            }
            .store(in: &cancellables)
    }
    
    func removeContact(by contactId: UUID) {
        do {
            try localStorageService.removeContact(with: contactId)
            imageService.deleteImageFromDocumentsDirectory(with: contacts.first(where: { $0.id == contactId })?.imageName)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getGroupedContactTableSections(by query: String = "") {
        var firstLetter: String = ""
        var grouped: [String: [ContactsRowViewState]] = [:]
        var currentContactCellsViewStates: [ContactsRowViewState] = contactCellsViewStates
        
        if !query.isEmpty {
            currentContactCellsViewStates = contactCellsViewStates.filter({ $0.fullNameText.contains(query) })
        }
        
        currentContactCellsViewStates.forEach { viewState in
            let trimmed = viewState.fullNameText.trimmingCharacters(in: .whitespaces)
            firstLetter = String(trimmed.prefix(1).uppercased())
            grouped[firstLetter, default: []].append(viewState)
        }
        
        contactsListSections = grouped
            .map { key, value in
                ContactsListSection(headerLetter: key, ContactRowViewStates: value)
            }
            .sorted { $0.headerLetter < $1.headerLetter }
    }
}




private extension HomePageViewModelImpl {
    func getContactCellsViewStates() -> [ContactsRowViewState] {
        var result: [ContactsRowViewState] = []
        contacts.forEach {
            result.append(ContactsRowViewState(contact: $0, avatarImage: imageService.makeImage(from: $0.imageName)))
        }
        return result
    }
}
