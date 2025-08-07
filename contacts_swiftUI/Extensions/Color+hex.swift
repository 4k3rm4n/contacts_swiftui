//
//  Color+hex.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import Foundation

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        var hexFormatted = hex
        if hexFormatted.hasPrefix("#") {
            hexFormatted.remove(at: hexFormatted.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        let r, g, b, a: Double
        switch hexFormatted.count {
        case 6:
            r = Double((rgbValue & 0xFF0000) >> 16) / 255
            g = Double((rgbValue & 0x00FF00) >> 8) / 255
            b = Double(rgbValue & 0x0000FF) / 255
            a = 1.0
        case 8:
            r = Double((rgbValue & 0xFF000000) >> 24) / 255
            g = Double((rgbValue & 0x00FF0000) >> 16) / 255
            b = Double((rgbValue & 0x0000FF00) >> 8) / 255
            a = Double(rgbValue & 0x000000FF) / 255
        default:
            r = 1
            g = 1
            b = 1
            a = 1
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }
}
