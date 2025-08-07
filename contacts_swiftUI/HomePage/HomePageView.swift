//
//  ContentView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import SwiftUI

protocol HomePageViewModel: ObservableObject {
    var contacts: [Contact] { get }
    var contactsListSections: [ContactsListSection] { get }
    func removeContact(by contactId: UUID)
    func getGroupedContactTableSections(by query: String)
}

struct HomePageView<ViewModel>: View where ViewModel: HomePageViewModel {
    @State var isShowingSheet: Bool = false
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            contentView
            .navigationTitle("Contacts")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("button") {
                        //
                        isShowingSheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            AddContactPage(viewModel: AddContactPageViewModelImpl(pageMode: .createContactMode))
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.contacts.isEmpty {
            EmptyContactsView()
        } else {
            ContactsView(viewModel: viewModel)
        }
    }
}

#Preview {
    HomePageView(viewModel: HomePageViewModelImpl())
}
