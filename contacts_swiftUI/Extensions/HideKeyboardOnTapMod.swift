//
//  HideKeyboardOnTapMod.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 26.07.2025.
//

import SwiftUI

struct HideKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

extension View {
    func hideKeyboardOnTap() -> some View {
        self.modifier(HideKeyboardOnTap())
    }
}
