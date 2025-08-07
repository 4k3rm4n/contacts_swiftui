//
//  DateInputFieldViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 07.07.2025.
//

import Foundation
import Combine

extension HeightInputFieldView {
    class ViewModel: ObservableObject {
        
        var field: AddContactPageFocusableField
        
        @Published var isTextFieldFocused: Bool = false
        @Published var height: Int?
        @Published var heightFieldViewState: HeightInputFieldView.HeightPickerViewState
        private var cancellables: Set<AnyCancellable> = []
        
        let viewState: HeightInputFieldView.ViewState
        
        init(viewState: HeightInputFieldView.ViewState) {
            self.viewState = viewState
            self.field = viewState.field
            self.heightFieldViewState = HeightPickerViewStates.nonActive.config
            $isTextFieldFocused.sink { [weak self] focused in
                guard let self else { return }
                if focused {
                    heightFieldViewState = HeightPickerViewStates.active.config
                } else {
                    heightFieldViewState = HeightPickerViewStates.nonActive.config
                }
            }
            .store(in: &cancellables)
        }
        
        func getValue() -> Int? {
            height
        }
    }
}
