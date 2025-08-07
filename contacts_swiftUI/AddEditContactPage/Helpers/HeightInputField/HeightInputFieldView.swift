//
//  DateInputFieldView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 07.07.2025.
//

import SwiftUI

struct HeightInputFieldView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var focusedField: FocusState<AddContactPageFocusableField?>.Binding//----
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Text(viewModel.viewState.text)
                    .font(.system(size: 17))
                    .foregroundStyle(viewModel.heightFieldViewState.textColor)
                    .containerRelativeFrame(.horizontal, alignment: .leading) { dimension,_ in
                        dimension * 0.4
                    }
                VStack {
                    HeightPickerTextField(height: $viewModel.height, placeholder: viewModel.viewState.textFieldPlaceholderText)
                    .font(.system(size: 17))
                    .focused(focusedField, equals: viewModel.field)
                    .onChange(of: focusedField.wrappedValue) { oldValue, newValue in
                        viewModel.isTextFieldFocused = newValue?.rawValue == viewModel.field.rawValue
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(viewModel.heightFieldViewState.separatorColor)
        }
        .padding(.horizontal, 16)
        .padding(.top, 2)
    }
}

extension HeightInputFieldView {
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
    
    struct HeightPickerViewState {
        let textColor: Color
        let separatorColor: Color
    }
    
    enum HeightPickerViewStates {
        case active
        case nonActive
        
        var config: HeightPickerViewState {
            switch self {
            case .nonActive:
                return HeightPickerViewState(
                    textColor: Color(hex: "#232326"),
                    separatorColor: Color(hex: "#E6E4EA"),
                )
            case .active:
                return HeightPickerViewState(
                    textColor: Color(hex: "#007AFF"),
                    separatorColor: Color(hex: "#007AFF"),
                )
            }
        }
    }
}

//#Preview {
//    HeightInputFieldView(viewModel: .init(viewState: HeightInputFieldView.ViewState(text: "Height, cm", textFieldPlaceholderText: "Height")))
//}
