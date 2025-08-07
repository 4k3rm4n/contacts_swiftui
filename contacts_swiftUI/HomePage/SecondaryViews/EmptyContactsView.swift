//
//  EmptyContactsView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import SwiftUI

struct EmptyContactsView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("EmptyContactsImage")
            Text("Your contact list is empty")
                .foregroundStyle(Color(hex: "#B8B6BF"))
                .font(.system(size: 17))
            Button("Add Contact") {
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#EFEFF4"))
        .padding(.top, -125)
    }
}

#Preview {
    EmptyContactsView()
}
