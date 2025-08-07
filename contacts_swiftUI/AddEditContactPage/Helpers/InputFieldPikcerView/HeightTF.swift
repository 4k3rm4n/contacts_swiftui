import SwiftUI
import UIKit

struct HeightPickerTextField: UIViewRepresentable {
    @Binding var height: Int?
    var placeholder: String

    class Coordinator: NSObject {
        var parent: HeightPickerTextField

        init(_ parent: HeightPickerTextField) {
            self.parent = parent
        }

        func valueChanged(_ sender: HeightInputFieldPickerView) {
            parent.height = sender.getSelectedValue()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.tintColor = .clear

        let heightPickerView = HeightInputFieldPickerView()
        heightPickerView.onSelectedHeightCallback = {
            context.coordinator.valueChanged(heightPickerView)
            textField.resignFirstResponder()
        }
        
        textField.inputView = heightPickerView

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if let height = height {
            uiView.text = "\(height) cm"
        }
    }
}
