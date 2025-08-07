//
//  DateInputFieldViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 07.07.2025.
//

import Foundation
import Combine

extension DateInputFieldView {
    class ViewModel: ObservableObject {
        
        var field: AddContactPageFocusableField
        
        @Published var isTextFieldFocused: Bool = false
        @Published var birthDay: Date?
        @Published var dateFieldViewState: DateInputFieldView.DatePickerViewState
        private var cancellables: Set<AnyCancellable> = []
        
        let viewState: DateInputFieldView.ViewState
        
        init(viewState: DateInputFieldView.ViewState) {
            self.field = viewState.field
            self.viewState = viewState
            self.dateFieldViewState = DatePickerViewStates.nonActive.config
            $isTextFieldFocused.sink { [weak self] focused in
                guard let self else { return }
                if focused {
                    dateFieldViewState = DatePickerViewStates.active.config
                } else {
                    dateFieldViewState = DatePickerViewStates.nonActive.config
                }
            }
            .store(in: &cancellables)
        }
        
        func getValue() -> Date? {
            birthDay
        }
    }
}
