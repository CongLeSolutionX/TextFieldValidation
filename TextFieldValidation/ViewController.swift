//
//  ViewController.swift
//  TextFieldValidation
//
//  Created by Cong Le on 3/5/22.
//

import UIKit

class CustomizedTextField: UITextField {
    public func setLeftTetView(
        text: String,
        textColor: UIColor? = nil,
        textFont: UIFont? = nil,
        isLeftLabelAccessible: Bool = true,
        leftLabelAccessibilityText: String? = nil,
        shouldAddingLeadingSpace: Bool = true
    ) {
        let textFieldView = UILabel(frame: CGRect())
        textFieldView.text = String(format: "%@%@", shouldAddingLeadingSpace ? "   ": "", text)
        textFieldView.font = textFont ?? UIFont.systemFont(ofSize: 17)
        textFieldView.textAlignment = .left
        textFieldView.textColor = .red
        textFieldView.sizeToFit()
        textFieldView.accessibilityLabel = leftLabelAccessibilityText ?? "\(text) Text Field".localized
        textFieldView.isAccessibilityElement = isLeftLabelAccessible
        self.leftView = textFieldView
        self.leftViewMode = .always
    }
}

extension String {
    var localized: String {
        return  NSLocalizedString(self, comment: "")
    }
}

class ViewController: UIViewController{
    lazy var textfield: UITextField = {
        let textFieldFrame = CGRect(x: 20, y: 100, width: 300, height: 40)
        let textfield = UITextField(frame: textFieldFrame)
        textfield.placeholder = "Enter text here"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .default
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.delegate = self
        return textfield
    }()
    
    lazy var customizedtextfield: CustomizedTextField = {
        let textFieldFrame = CGRect(x: 20, y: 100, width: 300, height: 40)
        let textfield = CustomizedTextField(frame: textFieldFrame)
        textfield.placeholder = "Enter text here"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .default
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.delegate = self
        textfield.setLeftTetView(text: "Customized text")
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        style()
        layout()
    }
    
    func style() {
        textfield.translatesAutoresizingMaskIntoConstraints = false
        customizedtextfield.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        self.view.addSubview(textfield)
        self.view.addSubview(customizedtextfield)
        NSLayoutConstraint.activate([
            textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customizedtextfield.topAnchor.constraint(equalTo: textfield.bottomAnchor, constant: 20),
            customizedtextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            customizedtextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // return NO to disallow editing.
        print("TextField should begin editing method called")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
        print("TextField should snd editing method called")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        // if implemented, called in place of textFieldDidEndEditing:
        print("TextField did end editing with reason method called")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // return NO to not change text
        print("While entering the characters this method gets called")
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
}

