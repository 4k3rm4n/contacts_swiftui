//
//  AddContactPage.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 05.07.2025.
//

import SwiftUI

enum AddContactPageFocusableField: String, Hashable {
    case firstName, lastName, phoneNumber, email, birthday, height, notes, drivingLicense
}

enum Mode {
    case createContactMode
    case editContactMode(contact: Contact)
}

protocol AddContactPageViewModel: ObservableObject {
    var contact: Contact { get }
    var pageMode: Mode { get }
    
    func saveContact()
    func saveImage(image: UIImage?)
}

struct AddContactPage<ViewModel>: View where ViewModel: AddContactPageViewModel {
    
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var drivingLicenseToggleIsOn = false
    @State private var notes: String = ""
    @State var contactImage: UIImage?
    @FocusState private var isNotesFocused: Bool
    @FocusState private var focusedField: AddContactPageFocusableField?
    
//    let firstNameField = TextInputFieldView(viewModel: .init(viewState: InputFields.firstName.baseInputFieldViewViewState))
//    let lastNameField = TextInputFieldView(viewModel: .init(viewState: InputFields.lastName.baseInputFieldViewViewState))
//    let phoneNumberField = TextInputFieldView(viewModel: .init(viewState: InputFields.phoneNumber.baseInputFieldViewViewState))
//    let emailField = TextInputFieldView(viewModel: .init(viewState: InputFields.email.baseInputFieldViewViewState))
//    let drivingLicenseField = TextInputFieldView(viewModel: .init(viewState: InputFields.drivingLicense.baseInputFieldViewViewState), focusedField: $focusedField)
//    let birthdayField = DateInputFieldView(viewModel: .init(viewState: DateInputFieldView.ViewState(text: "Birthday", textFieldPlaceholderText: "Birthday")))
//    let heightField = HeightInputFieldView(viewModel: .init(viewState: HeightInputFieldView.ViewState(text: "Height, cm", textFieldPlaceholderText: "Height")))
//    
    
    let firstNameViewModel = TextInputFieldView.ViewModel(viewState: InputFields.firstName.baseInputFieldViewViewState)
    let lastNameViewModel = TextInputFieldView.ViewModel(viewState: InputFields.lastName.baseInputFieldViewViewState)
    let phoneNumberViewModel = TextInputFieldView.ViewModel(viewState: InputFields.phoneNumber.baseInputFieldViewViewState)
    let emailViewModel = TextInputFieldView.ViewModel(viewState: InputFields.email.baseInputFieldViewViewState)
    let drivingLicenseViewModel = TextInputFieldView.ViewModel(viewState: InputFields.drivingLicense.baseInputFieldViewViewState)
    let birthdayViewModel = DateInputFieldView.ViewModel(viewState: DateInputFieldView.ViewState(text: "Birthday", textFieldPlaceholderText: "Birthday", field: .birthday))
    let heightViewModel = HeightInputFieldView.ViewModel(viewState: HeightInputFieldView.ViewState(text: "Height, cm", textFieldPlaceholderText: "Height", field: .height))
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    private func isAllFieldsAreValid() -> Bool {
        let fieldsViewModels = [firstNameViewModel, lastNameViewModel, phoneNumberViewModel, emailViewModel]
        var isAllFieldsAreValid: Bool = true
        fieldsViewModels.forEach {
            do {
                try $0.validate()
            } catch {
                isAllFieldsAreValid = false
            }
        }
        return isAllFieldsAreValid
    }
    
    private func isAtLeastOneRequiredFieldIsNonNil() -> Bool {
        let requiredFieldsViewModels = [firstNameViewModel, lastNameViewModel, phoneNumberViewModel, emailViewModel]
        return !requiredFieldsViewModels.compactMap { $0.getValue() }.isEmpty
    }
    
    var textFields: some View {
        VStack {
            TextInputFieldView(viewModel: firstNameViewModel, focusedField: $focusedField)
                .id(AddContactPageFocusableField.firstName.rawValue)
            TextInputFieldView(viewModel: lastNameViewModel, focusedField: $focusedField)
                .id(AddContactPageFocusableField.lastName.rawValue)
            TextInputFieldView(viewModel: phoneNumberViewModel, focusedField: $focusedField)
                .id(AddContactPageFocusableField.phoneNumber.rawValue)
            TextInputFieldView(viewModel: emailViewModel, focusedField: $focusedField)
                .id(AddContactPageFocusableField.email.rawValue)
            DateInputFieldView(viewModel: birthdayViewModel, focusedField: $focusedField)
                .id(AddContactPageFocusableField.birthday.rawValue)
            HeightInputFieldView(viewModel: heightViewModel, focusedField: $focusedField)
                .id(AddContactPageFocusableField.height.rawValue)
        }
        .padding(.top, 8)
        .background(.white)
        .padding(.bottom, 25)
    }
    
    var drivingLicenseField: some View {
        VStack {
            VStack {
                HStack {
                    Text("Driving license")
                        .font(.system(size: 17))
                        .foregroundStyle(Color(hex: "#232326"))
                        .containerRelativeFrame(.horizontal, alignment: .leading) { dimension,_ in
                            dimension * 0.4
                        }
                    Spacer()
                    Toggle("", isOn: $drivingLicenseToggleIsOn)
                        .labelsHidden()
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(Color(hex: "#E6E4EA"))
            }
            .padding(.horizontal, 16)
            if drivingLicenseToggleIsOn {
                TextInputFieldView(viewModel: drivingLicenseViewModel, focusedField: $focusedField)
                    .id(AddContactPageFocusableField.drivingLicense.rawValue)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.top, 8)
        .background(.white)
        .padding(.bottom, 25)
    }
    
    var notesField: some View {
        HStack {
            Text("Notes")
                .font(.system(size: 17))
                .foregroundStyle(Color(hex: "#232326"))
                .containerRelativeFrame(.horizontal, alignment: .leading) { dimension,_ in
                    dimension * 0.4
                }
            
            ZStack(alignment: .leading) {
                TextEditor(text: $notes)
                    .focused($focusedField, equals: .notes)
                    .id(AddContactPageFocusableField.notes.rawValue)
                if notes.isEmpty && focusedField != .notes {
                    Text("Notes")
                        .foregroundColor(Color(hex: "#B8B6BF"))
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.white)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                AddContactPageHeaderView(selectedImage: $contactImage)
                    .padding(.top, 16)
                GeometryReader { geometry in
                    ScrollViewReader { proxy in
                        ScrollView {
                            textFields
                            
                            //----
                            
                            drivingLicenseField
                            
                            //----
                            
                            notesField
                        }
                        .onChange(of: focusedField) { oldValue, newValue in
                            guard let field = newValue else { return }
                            withAnimation {
                                proxy.scrollTo(field.rawValue, anchor: .bottom)
                            }
                        }
                        .onChange(of: notes) {
                            proxy.scrollTo(focusedField?.rawValue, anchor: .bottom)
                        }
                        .animation(.easeInOut, value: drivingLicenseToggleIsOn)
                        .hideKeyboardOnTap()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#EFEFF4"))
            .navigationTitle("New Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.white, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        guard isAllFieldsAreValid() && isAtLeastOneRequiredFieldIsNonNil() else { return }
                        viewModel.contact.firstName = firstNameViewModel.getValue()
                        viewModel.contact.lastName = lastNameViewModel.getValue()
                        viewModel.contact.email = emailViewModel.getValue()
                        viewModel.contact.phoneNumber = phoneNumberViewModel.getValue()
                        viewModel.contact.height = heightViewModel.getValue()
                        viewModel.contact.birthday = birthdayViewModel.getValue()
                        viewModel.contact.drivingLicenseNumber = drivingLicenseViewModel.getValue()
                        viewModel.contact.notes = notes.isEmpty ? nil : notes
                        viewModel.saveImage(image: contactImage)
                        viewModel.saveContact()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}

extension AddContactPage {
    enum InputFields {
        case firstName
        case lastName
        case phoneNumber
        case email
        case drivingLicense
        
        var baseInputFieldViewViewState: TextInputFieldView.ViewState {
            switch self {
            case .firstName:
                return TextInputFieldView.ViewState(text: "First Name", textFieldPlaceholderText: "First Name", regexErrorMap: [RegexErrors.maxCharactersExceeded: RegexPattern.maxCharactersPattern, RegexErrors.onlySpaceCharacters: RegexPattern.onlySpaceCharactersPattern], field: .firstName)
            case .lastName:
                return TextInputFieldView.ViewState(text: "Last Name", textFieldPlaceholderText: "Last Name", regexErrorMap: [RegexErrors.maxCharactersExceeded: RegexPattern.maxCharactersPattern, RegexErrors.onlySpaceCharacters: RegexPattern.onlySpaceCharactersPattern], field: .lastName)
            case .phoneNumber:
                return TextInputFieldView.ViewState(text: "Phone Number", textFieldPlaceholderText: "Phone Number", textFieldKeyboardType: .phonePad, regexErrorMap: [RegexErrors.phoneNumberFormatError: RegexPattern.phoneNumberFormatPattern, RegexErrors.maxCharactersExceeded: RegexPattern.maxCharactersPattern], field: .phoneNumber)
            case .email:
                return TextInputFieldView.ViewState(text: "Email", textFieldPlaceholderText: "Email", textFieldKeyboardType: .emailAddress, regexErrorMap: [RegexErrors.emailFormatError: RegexPattern.emailFormatPattern], field: .email)
            case .drivingLicense:
                return TextInputFieldView.ViewState(text: "Driving License", textFieldPlaceholderText: "Driving license number", field: .drivingLicense)
            }
        }
    }
}

#Preview {
    AddContactPage(viewModel: AddContactPageViewModelImpl(pageMode: .createContactMode))
}
