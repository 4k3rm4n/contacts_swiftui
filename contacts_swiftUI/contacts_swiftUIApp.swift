//
//  contacts_swiftUIApp.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import SwiftUI

@main
struct contacts_swiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomePageView(viewModel: HomePageViewModelImpl())
        }
    }
}
