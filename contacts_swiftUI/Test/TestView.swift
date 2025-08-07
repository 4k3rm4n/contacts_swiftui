//
//  TestView.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 13.07.2025.
//

import SwiftUI
import Combine

struct TestView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            if let image = viewModel.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } else {
                Text("No Image")
            }
        }
        .task {
            guard let url = URL(string: "https://fastly.picsum.photos/id/382/400/400.jpg?hmac=BJSVbce-q-cmCNyMdU7Q0S3drIGWvJFU35L9KYpWF4I") else { return }
            viewModel.setImage(with: url)
        }
    }
}

#Preview {
    TestView()
}
