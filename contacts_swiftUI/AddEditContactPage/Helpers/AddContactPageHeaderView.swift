//
//  AddContactPageHeaderView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 05.07.2025.
//

import SwiftUI
import PhotosUI

struct AddContactPageHeaderView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var selectedImage: UIImage?
    
    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 128, height: 128)
                    .clipShape(Circle())
            } else {
                Image("EmptyContactImage")
                    .resizable()
                    .frame(width: 128, height: 128)
            }
            
//            Button {
//                
//            } label: {
//                Text("Add Photo")
//                    .font(.system(size: 14))
//            }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images) {
                    Text("Add Photo")
                        .font(.system(size: 14))
                }
                .contentShape(Rectangle())
                .onChange(of: selectedItem) { _, _ in
                    Task {
                        if let selectedItem, let data = try? await selectedItem.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                selectedImage = uiImage
                            }
                        }
//                        selectedItem = nil
                    }
                    
                }
        }
    }
}

//#Preview {
//    AddContactPageHeaderView(selectedImage: <#T##Binding<UIImage?>#>)
//}
