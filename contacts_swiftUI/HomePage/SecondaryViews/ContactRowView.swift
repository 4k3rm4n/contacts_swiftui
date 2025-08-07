//
//  ContactRowView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import SwiftUI

struct ContactRowView: View {
    var contactRowViewState: ContactsRowViewState
    var body: some View {
        HStack {
            contactRowViewState.avatar
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
            VStack(alignment: .leading){
                Text(contactRowViewState.fullNameText)
                    .font(.system(size: 15))
                Text(contactRowViewState.secondaryInfoText ?? "")
                    .foregroundStyle(Color(hex: "#9A99A2"))
                    .font(.system(size: 11))
            }
        }
    }
}

#Preview {
    ContactRowView(contactRowViewState: ContactsRowViewState(contact: Contact(firstName: "Andrii", lastName: "Melnyk", email: "andriy.m@example.com", phoneNumber: "+380671234567"), avatarImage: Image("EmptyContactImage")))
}
