//
//  UIApplication+endEditing.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 26.07.2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
