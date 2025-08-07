//
//  HeightInputFieldPickerView.swift
//  contacts
//
//  Created by Bogdan on 18.05.2025.
//

import UIKit

class HeightInputFieldPickerView: InputFieldBasePickerView {
    private var heightPicker: UIPickerView = UIPickerView()
    var onSelectedHeightCallback: (() -> Void)?
    private let numbers = Array(0...9)
    private let countOfComponents = 3
    
    override func setupPicker() {
        super.setupPicker()
        heightPicker.dataSource = self
        heightPicker.delegate = self
        mainStackView.addArrangedSubview(heightPicker)
    }
    
    override func didTouchConfirmButton() {
        super.didTouchConfirmButton()
        onSelectedHeightCallback?()
    }
    
    func getSelectedValue() -> Int {
        var result = 0
        for component in 0..<countOfComponents {
            let selectedRow = heightPicker.selectedRow(inComponent: component)
            result = result * 10 + numbers[selectedRow]
        }
        return result
    }
    
    func setHeight(height: Int) {
        let digits = [(height / 100) % 10, (height / 10) % 10, height % 10]
        for (component, digit) in digits.enumerated() {
            heightPicker.selectRow(digit, inComponent: component, animated: false)
        }
    }
}

extension HeightInputFieldPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        countOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numbers.count
    }
}

extension HeightInputFieldPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numbers[row])"
    }
}
