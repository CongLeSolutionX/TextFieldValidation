//
//  ViewController.swift
//  TextFieldValidation
//
//  Created by Cong Le on 3/5/22.
//

import UIKit

class ViewController: UIViewController{
    lazy var originalTextfield: UITextField = {
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
    let errorTextForNormalTextField = UILabel()
    let errorTextForCustomizedTextField = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        style()
        layout()
        resetForm()
    }
    
    func resetForm() {
        originalTextfield.text = ""
        customizedtextfield.text = ""
        
        errorTextForNormalTextField.isHidden = false
        errorTextForCustomizedTextField.isHidden = false
        
        errorTextForNormalTextField.text = "Required"
        errorTextForCustomizedTextField.text = "Required"
    }
    func style() {
        originalTextfield.translatesAutoresizingMaskIntoConstraints = false
        customizedtextfield.translatesAutoresizingMaskIntoConstraints = false
        errorTextForNormalTextField.translatesAutoresizingMaskIntoConstraints = false
        errorTextForCustomizedTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        self.view.addSubview(originalTextfield)
        self.view.addSubview(customizedtextfield)
        self.view.addSubview(errorTextForNormalTextField)
        self.view.addSubview(errorTextForCustomizedTextField)
        
        NSLayoutConstraint.activate([
            originalTextfield.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            originalTextfield.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            originalTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            originalTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
           
            errorTextForNormalTextField.topAnchor.constraint(equalTo: originalTextfield.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            errorTextForNormalTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            errorTextForNormalTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            customizedtextfield.topAnchor.constraint(equalTo: errorTextForNormalTextField.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            customizedtextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            customizedtextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            errorTextForCustomizedTextField.topAnchor.constraint(equalTo: customizedtextfield.bottomAnchor, constant: 20),
            errorTextForCustomizedTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            errorTextForCustomizedTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
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
        //print("While entering the characters this method gets called")
        let isValidTextField = isValidTextField(existingText: textField, newText: string)
        if !isValidTextField {
            errorTextForNormalTextField.text = "This is an error"
        } else {
            errorTextForNormalTextField.text = ""
        }
        return true
    }
    
    func isValidTextField(existingText: UITextField, newText: String) -> Bool {
        let specialCharacters = "!~`@#$%^&*-+();:={}[],.<>?\\/\"\'"
        var searchText = existingText.text! + newText
        
        let characterSet = CharacterSet(charactersIn: specialCharacters)
        
        if newText == "" {
            searchText.removeLast()
        }
        
        if (newText.rangeOfCharacter(from: characterSet) != nil) {
            print("matched special characters")
            self.view.backgroundColor = .red
            existingText.textColor = .black
            return false
        } else if (searchText.rangeOfCharacter(from: characterSet) == nil) {
            self.view.backgroundColor = .green
            existingText.textColor = .black
            return true
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // called when clear button pressed. return NO to ignore (no notifications)
        print("TextField should clear method called")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // called when 'return' key pressed. return NO to ignore.
        //print("TextField should return method called")
        // may be useful: textField.resignFirstResponder()
        return true
    }
}

