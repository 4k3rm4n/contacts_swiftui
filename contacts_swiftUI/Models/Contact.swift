//
//  Contact.swift
//  contacts_swiftUI
//
//  Created by Bogdan on 04.07.2025.
//

import Foundation

class Contact: Identifiable, Hashable, Codable {
    var id = UUID()
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var birthday: Date?
    var height: Int?
    var drivingLicenseNumber: String?
    var notes: String?
    var imageName: String?
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    init(firstName: String? = nil, lastName: String? = nil, email: String? = nil, phoneNumber: String? = nil, birthday: Date? = nil, height: Int? = nil, drivingLicenseNumber: String? = nil, notes: String? = nil, imageName: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.birthday = birthday
        self.height = height
        self.drivingLicenseNumber = drivingLicenseNumber
        self.notes = notes
        self.imageName = imageName
    }
    
    static let testFull = [
        Contact(firstName: "Ivan", lastName: "Petrenko", email: "ivan.petrenko@example.com", phoneNumber: "+380671112233"),
        Contact(firstName: "Olena", lastName: "Kovalchuk", email: "olena.k@example.com", phoneNumber: "+380501234567"),
        Contact(firstName: "Maksym", lastName: "Shevchenko", email: "max.shevchenko@example.com", phoneNumber: "+380931234567"),
        Contact(firstName: "Svitlana", lastName: "Bondarenko", email: "svitlana.b@example.com", phoneNumber: "+380991112233"),
        Contact(firstName: "Sndrii", lastName: "Melnyk", email: "andriy.m@example.com", phoneNumber: "+380671234567")
    ]
    
    static let testEmpty: [Contact] = []
    
    static let testContact = Contact(firstName: "Іван", lastName: "Петренко", email: "ivan.petrenko@example.com", phoneNumber: "+380671112233")
}
