//
//  TextInputFieldViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 06.07.2025.
//

import SwiftUI
import Combine

extension TextInputFieldView {
    class ViewModel: ObservableObject {
        
        var field: AddContactPageFocusableField
        
        @Published var isTextFieldFocused: Bool = false
        @Published var text: String = ""
        @Published var textFieldViewState: TextInputFieldView.TextFieldViewState
        let viewState: TextInputFieldView.ViewState
        private var cancellables: Set<AnyCancellable> = []
        
        init(viewState: TextInputFieldView.ViewState) {
            self.viewState = viewState
            self.field = viewState.field
            self.textFieldViewState = TextFieldViewStates.nonActive.config
            $isTextFieldFocused.sink { [weak self] focused in
                guard let self else { return }
                if focused {
                    textFieldViewState = TextFieldViewStates.active.config
                } else {
                    do {
                        try validate()
                        textFieldViewState = TextFieldViewStates.nonActive.config
                    } catch let error {
                        textFieldViewState = TextFieldViewStates.nonActiveError(error.localizedDescription).config
                    }
                }
            }
            .store(in: &cancellables)
        }
        
        func getValue() -> String? {
            text.isEmpty ? nil : text
        }
        
        func validate() throws {
            for (error, regex) in viewState.regexErrorMap {
                if !text.isMatch(regex: regex) {
                    throw error
                }
            }
        }
    }
}
