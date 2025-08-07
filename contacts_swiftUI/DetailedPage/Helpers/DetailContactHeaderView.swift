//
//  DetailContactHeaderView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 05.07.2025.
//

import SwiftUI

struct DetailContactHeaderView: View {
    
    var viewState: ViewState
    
    var body: some View {
        VStack {
            viewState.avatarImage
                .resizable()
                .scaledToFill()
                .frame(width: 128, height: 128)
                .clipShape(Circle())
            Text(viewState.fullNameText)
        }
        .padding(.vertical, 30)
    }
    
    struct ViewState {
        let fullNameText: String
        let avatarImage: Image
        
        init(firstName: String?, lastName: String?, avatarImage: Image?) {
            self.fullNameText = "\(firstName ?? "") \(lastName ?? "")"
            if let image = avatarImage {
                self.avatarImage = image
            } else {
                self.avatarImage = Image("EmptyContactImage")
            }
        }
    }
}

#Preview {
    DetailContactHeaderView(viewState: DetailContactHeaderView.ViewState(firstName: "test", lastName: "test", avatarImage: Image("EmptyContactImage")))
}
