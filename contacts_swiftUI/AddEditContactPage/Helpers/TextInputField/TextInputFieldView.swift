//
//  BaseInputFieldView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 06.07.2025.
//

import SwiftUI

struct TextInputFieldView: View {
    
    @ObservedObject var viewModel: ViewModel
    var focusedField: FocusState<AddContactPageFocusableField?>.Binding//----
    
    var body: some View {
        VStack() {
            HStack() {
                Text(viewModel.viewState.text)
                    .font(.system(size: 17))
                    .foregroundStyle(viewModel.textFieldViewState.textColor)
                    .containerRelativeFrame(.horizontal, alignment: .leading) { dimension,_ in
                        dimension * 0.4
                    }
                VStack(alignment: .leading) {
                    if let errorMassage = viewModel.textFieldViewState.errorMassage {
                        Text(errorMassage)
                            .foregroundStyle(Color(hex: "#EB5757"))
                            .font(.system(size: 12))
                            .transition(.opacity)
                    }
                    TextField(viewModel.viewState.textFieldPlaceholderText, text: $viewModel.text) {
                        UIApplication.shared.endEditing()
                    }
                    .keyboardType(viewModel.viewState.textFieldKeyboardType)
                    .focused(focusedField, equals: viewModel.field)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .onChange(of: focusedField.wrappedValue) { oldValue, newValue in
                        viewModel.isTextFieldFocused = newValue?.rawValue == viewModel.field.rawValue
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(viewModel.textFieldViewState.separatorColor)
        }
        .padding(.horizontal, 16)
        .padding(.top, 2)
    }
}

extension TextInputFieldView {
    struct ViewState {
        let text: String
        let textFieldPlaceholderText: String
        let textFieldKeyboardType: UIKeyboardType
        let regexErrorMap: [RegexErrors: String]
        let field: AddContactPageFocusableField
        
        init(text: String, textFieldPlaceholderText: String, textFieldKeyboardType: UIKeyboardType = .default, regexErrorMap: [RegexErrors: String] = [:], field: AddContactPageFocusableField) {
            self.text = text
            self.textFieldPlaceholderText = textFieldPlaceholderText
            self.textFieldKeyboardType = textFieldKeyboardType
            self.regexErrorMap = regexErrorMap
            self.field = field
        }
    }
    
    struct TextFieldViewState {
        let textColor: Color
        let separatorColor: Color
        let errorMassage: String?
    }
    
    enum TextFieldViewStates {
        case active
        case nonActive
        case nonActiveError(String)
        
        var config: TextFieldViewState {
            switch self {
            case .nonActive:
                return TextFieldViewState(
                    textColor: Color(hex: "#232326"),
                    separatorColor: Color(hex: "#E6E4EA"),
                    errorMassage: nil
                )
            case .active:
                return TextFieldViewState(
                    textColor: Color(hex: "#007AFF"),
                    separatorColor: Color(hex: "#007AFF"),
                    errorMassage: nil
                )
            case .nonActiveError(let message):
                return TextFieldViewState(
                    textColor: Color(hex: "#EB5757"),
                    separatorColor: Color(hex: "#EB5757"),
                    errorMassage: message
                )
            }
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        @FocusState private var focusedField: AddContactPageFocusableField?
        
        var body: some View {
            TextInputFieldView(
                viewModel: .init(
                    viewState: TextInputFieldView.ViewState(
                        text: "First Name",
                        textFieldPlaceholderText: "First Name",
                        regexErrorMap: [
                            RegexErrors.maxCharactersExceeded: RegexPattern.maxCharactersPattern,
                            RegexErrors.onlySpaceCharacters: RegexPattern.onlySpaceCharactersPattern
                        ],
                        field: .firstName
                    )
                ),
                focusedField: $focusedField
            )
        }
    }

    return PreviewWrapper()
}
