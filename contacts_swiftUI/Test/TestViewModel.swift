//
//  TestViewModel.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 13.07.2025.
//

import SwiftUI

extension TestView {
    class ViewModel: ObservableObject {
        @Published var uiImage: UIImage?
        
        func loadImage(with url: URL) async throws -> UIImage {
            return try await withCheckedThrowingContinuation { continuation in
                URLSession.shared.dataTask(with: url) { data, _, error in
                    
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else if let data = data, let image = UIImage(data: data) {
                        continuation.resume(returning: image)
                    } else {
                        continuation.resume(throwing: URLError(.cannotDecodeContentData))
                    }
                    
                }.resume()
            }
        }
        
        func setImage(with url: URL) {
            Task { @MainActor in
                uiImage = try? await loadImage(with: url)
            }
        }
    }
}
