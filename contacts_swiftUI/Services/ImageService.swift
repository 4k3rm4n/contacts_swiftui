//
//  ImageService.swift
//  contacts
//
//  Created by Bogdan on 09.06.2025.
//

import SwiftUI

protocol ImageServiceProtocol {
    func deleteImageFromDocumentsDirectory(with imageName: String?)
    func makeImage(from imageName: String?) -> Image?
    func saveImageToDocumentsDirectory(with image: UIImage, contactUUID: UUID) -> String?
}

struct ImageService: ImageServiceProtocol {
    
    func deleteImageFromDocumentsDirectory(with imageName: String?) {
        guard let imageName = imageName else { return }
        let fileManager = FileManager.default
        guard let documentDirectory = try? fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ) else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(imageName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
            } catch {
                print("Помилка при видаленні файлу: \(error.localizedDescription)")
            }
        }
    }
    
    func saveImageToDocumentsDirectory(with image: UIImage, contactUUID: UUID) -> String? {
        
        let filename = contactUUID.uuidString + ".jpeg"
        
        let fileManager = FileManager.default
        guard let documentDirectory = try? fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ) else { return nil}
        
        print(documentDirectory)
        
        let saveURL = documentDirectory.appendingPathComponent(filename)
        
        if let jpegData = image.jpegData(compressionQuality: 1.0) {
            do {
                try jpegData.write(to: saveURL)
            } catch {
                print("Помилка збереження: \(error)")
            }
        }
        
        return filename
    }
    
    func makeImage(from imageName: String?) -> Image? {
        guard let imageName = imageName else { return nil }
        
        let fileManager = FileManager.default
        guard let documentDirectory = try? fileManager.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ) else { return nil}
        
        let path = documentDirectory.appendingPathComponent(imageName).path
        
        
        guard let image = UIImage(contentsOfFile: path) else { return nil }
        return Image(uiImage: image)
    }
}
