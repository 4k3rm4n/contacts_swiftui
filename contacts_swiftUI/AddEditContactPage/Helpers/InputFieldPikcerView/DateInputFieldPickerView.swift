//
//  DateInputFieldPickerView.swift
//  contacts
//
//  Created by Bogdan on 18.05.2025.
//

import UIKit

class DateInputFieldPickerView: InputFieldBasePickerView {
    private var datePicker: UIDatePicker = UIDatePicker()
    var onSelectedDateCallback: (() -> Void)?
    
    override func setupPicker() {
        super.setupPicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        let calendar = Calendar.current
        let components = DateComponents(year: 1900, month: 1, day: 1)
        datePicker.minimumDate = calendar.date(from: components)
        mainStackView.addArrangedSubview(datePicker)
    }
    
    override func didTouchConfirmButton() {
        super.didTouchConfirmButton()
        onSelectedDateCallback?()
    }
    
    func setDate(date: Date) {
        datePicker.date = date
    }
    
    func getDate() -> Date {
        datePicker.date
    }
}
