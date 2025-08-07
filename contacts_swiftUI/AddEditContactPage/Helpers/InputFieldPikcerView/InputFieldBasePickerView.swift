//
//  CustomPickerButtonContainerView.swift
//  contacts
//
//  Created by Bogdan on 18.05.2025.
//

import UIKit

class InputFieldBasePickerView: UIView {

    let mainStackView: UIStackView = .init(frame: .zero)
    private let confirmButton: UIButton = .init(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 336)
        ])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        setupPicker()
        setupButton()
    }
    
    func setupPicker() {
        
    }
    
    func setupButton() {
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.backgroundColor = .systemBlue
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 8
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        confirmButton.addTarget(self, action: #selector(didTouchConfirmButton), for: .touchUpInside)
        mainStackView.addArrangedSubview(confirmButton)
    }
    
    @objc func didTouchConfirmButton() {
        
    }
}
