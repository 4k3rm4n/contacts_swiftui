//
//  DetailedContactView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 05.07.2025.
//

import SwiftUI

protocol DetailedContactViewModel: ObservableObject {
    var contact: Contact { get }
    var generalInfoSectionViewStates: [DetailedContactRowView.ViewState] { get }
    var drivingLicenseSectionViewState: DetailedContactRowView.ViewState? { get }
    var notesSectionViewState: DetailedContactRowView.ViewState? { get }
    
    func getHeaderViewState() -> DetailContactHeaderView.ViewState
}

struct DetailedContactView<ViewModel>: View where ViewModel: DetailedContactViewModel {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                DetailContactHeaderView(viewState: viewModel.getHeaderViewState())
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.generalInfoSectionViewStates) {viewState in
                        DetailedContactRowView(viewState: viewState)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(Color(hex: "#E6E4EA"))
                    if let drivingLicenseViewState = viewModel.drivingLicenseSectionViewState {
                        DetailedContactRowView(viewState: drivingLicenseViewState)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color(hex: "#E6E4EA"))
                    }
                    
                    if let notesViewState = viewModel.notesSectionViewState {
                        DetailedContactRowView(viewState: notesViewState)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundStyle(Color(hex: "#E6E4EA"))
                    }
                    
                    Text("Delete Contact")
                        .font(.system(size: 17))
                        .foregroundStyle(Color(hex: "#EB5757"))
                        .padding(.leading, 15)
                        .onTapGesture {
                            //
                        }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 10)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarBackgroundVisibility(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            //
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DetailedContactView(viewModel: DetailedContactViewModelImpl(contactId: UUID()))
}
