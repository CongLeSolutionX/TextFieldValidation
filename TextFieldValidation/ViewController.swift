//
//  ViewController.swift
//  TextFieldValidation
//
//  Created by Cong Le on 3/5/22.
//

import UIKit

class ViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        style()
        layout()
    }
    
    func style() {
        textfield.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        self.view.addSubview(textfield)
        NSLayoutConstraint.activate([
            textfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfield.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
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

