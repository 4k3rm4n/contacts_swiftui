//
//  DetailedContactRowView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 30.07.2025.
//

import SwiftUI

struct DetailedContactRowView: View {
    
    var viewState: ViewState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(viewState.fieldName)
                .font(.system(size: 11))
                .foregroundStyle(Color(hex: "#9A99A2"))
            Text(viewState.infoText)
                .font(.system(size: 15))
                .foregroundStyle(Color(hex: "#232326"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 15)
    }
    
    struct ViewState: Identifiable {
        let id = UUID()
        let fieldName: String
        let infoText: String
        
        init(fieldName: String, infoText: String) {
            self.fieldName = fieldName
            self.infoText = infoText
        }
    }
}

#Preview {
    DetailedContactRowView(viewState: .init(fieldName: "fieldName", infoText: "infoText"))
}
