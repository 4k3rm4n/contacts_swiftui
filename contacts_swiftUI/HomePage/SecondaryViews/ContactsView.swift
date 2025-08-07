//
//  ContactsView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import SwiftUI

struct ContactsView: View {
    let viewModel: any HomePageViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.contactsListSections) { section in
                Section(header: Text(section.headerLetter)) {
                    ForEach(section.contactRowViewStates) { viewState in
                        NavigationLink(destination: DetailedContactView(viewModel: DetailedContactViewModelImpl(contactId: viewState.id))) {
                            ContactRowView(contactRowViewState: viewState)
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let idToDelete = section.contactRowViewStates[index].id
                            viewModel.removeContact(by: idToDelete)
                        }
                    }
                }
            }
        }
        .background(Color(hex: "#EFEFF4"))
        .listStyle(.plain)
        .environment(\.defaultMinListHeaderHeight, 1)
    }
}

//#Preview {
//    HomePageView()
//}
