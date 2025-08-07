//
//  DateInputFieldView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 07.07.2025.
//

import SwiftUI

struct DateInputFieldView: View {

    @ObservedObject var viewModel: ViewModel
    
    var focusedField: FocusState<AddContactPageFocusableField?>.Binding//----
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text(viewModel.viewState.text)
                    .font(.system(size: 17))
                    .foregroundStyle(viewModel.dateFieldViewState.textColor)
                    .containerRelativeFrame(.horizontal, alignment: .leading) { dimension,_ in
                        dimension * 0.4
                    }
                VStack {
                    DatePickerTextField(date: $viewModel.birthDay, placeholder: viewModel.viewState.textFieldPlaceholderText)
                        .focused(focusedField, equals: viewModel.field)
                        .onChange(of: focusedField.wrappedValue) { oldValue, newValue in
                            viewModel.isTextFieldFocused = newValue?.rawValue == viewModel.field.rawValue
                        }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(viewModel.dateFieldViewState.separatorColor)
        }
        .padding(.horizontal, 16)
        .padding(.top, 2)
    }
}

extension DateInputFieldView {
    struct ViewState {
        let text: String
        let textFieldPlaceholderText: String
        let field: AddContactPageFocusableField
        
        init(text: String, textFieldPlaceholderText: String, field: AddContactPageFocusableField) {
            self.text = text
            self.textFieldPlaceholderText = textFieldPlaceholderText
            self.field = field
        }
    }
    
    struct DatePickerViewState {
        let textColor: Color
        let separatorColor: Color
    }
    
    enum DatePickerViewStates {
        case active
        case nonActive
        
        var config: DatePickerViewState {
            switch self {
            case .nonActive:
                return DatePickerViewState(
                    textColor: Color(hex: "#232326"),
                    separatorColor: Color(hex: "#E6E4EA"),
                )
            case .active:
                return DatePickerViewState(
                    textColor: Color(hex: "#007AFF"),
                    separatorColor: Color(hex: "#007AFF"),
                )
            }
        }
    }
}

//#Preview {
//    DateInputFieldView(viewModel: .init(viewState: DateInputFieldView.ViewState(text: "Birthday", textFieldPlaceholderText: "Birthday")))
//}
