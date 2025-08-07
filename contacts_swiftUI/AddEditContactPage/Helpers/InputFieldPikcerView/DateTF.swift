import SwiftUI
import UIKit

struct DatePickerTextField: UIViewRepresentable {
    @Binding var date: Date?
    var placeholder: String

    class Coordinator: NSObject {
        var parent: DatePickerTextField

        init(_ parent: DatePickerTextField) {
            self.parent = parent
        }

        func dateChanged(_ sender: DateInputFieldPickerView) {
            parent.date = sender.getDate()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.tintColor = .clear

        let datePickerView = DateInputFieldPickerView()
        datePickerView.onSelectedDateCallback = {
            context.coordinator.dateChanged(datePickerView)
            textField.resignFirstResponder()
        }
        
        textField.inputView = datePickerView

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        if let date = date {
            uiView.text = formatter.string(from: date)
        }
    }
}
