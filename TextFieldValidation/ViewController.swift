//
//  ViewController.swift
//  TextFieldValidation
//
//  Created by Cong Le on 3/5/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    private enum Constants {
        static let lineSpacer: CGFloat = 20
    }
    
    lazy var originalTextField: UITextField = {
        // let textFieldFrame = CGRect(x: 20, y: 100, width: 300, height: 40)
        let textfield = UITextField()
        textfield.placeholder = "Original text field"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .default
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.delegate = self
        return textfield
    }()
    
    lazy var textFieldWithRightImageView: CongUITextField = {
        let textfield = CongUITextField()
        textfield.placeholder = "UITextField with right view"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .default
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.delegate = self
       
        let rightImageView = UIImageView()
        rightImageView.backgroundColor = .cyan
        rightImageView.image = UIImage(systemName: "house")
        rightImageView.contentMode = .scaleAspectFit
        rightImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        
        textfield.rightView = rightImageView
        textfield.rightViewMode = .always
        
        textfield.setLeftTextView(text: "Cong")
        return textfield
    }()
    lazy var customizedTextField: CustomizedTextField = {
        // let textFieldFrame = CGRect(x: 20, y: 100, width: 300, height: 40)
        let textfield = CustomizedTextField()//CustomizedTextField(frame: textFieldFrame)
        textfield.placeholder = "Enter text here"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .default
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.delegate = self
        
        let customCloseButton = UIButton(type: .close)
        
        let padding: CGFloat = 20
        let rightView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: customCloseButton.frame.width + padding,
                height: customCloseButton.frame.height
            )
        )
        rightView.backgroundColor = .orange
        rightView.addSubview(customCloseButton)
        customCloseButton.translatesAutoresizingMaskIntoConstraints = true
        
        NSLayoutConstraint.activate([
            customCloseButton.topAnchor.constraint(equalTo: rightView.topAnchor),
            customCloseButton.bottomAnchor.constraint(equalTo: rightView.bottomAnchor),
            customCloseButton.leadingAnchor.constraint(equalTo: rightView.leadingAnchor),
            customCloseButton.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -padding)
        ])
  
        textfield.rightView = rightView
        textfield.rightViewMode = .always
        
        textfield.setLeftTextView(text: "Customized text")
        return textfield
    }()
    
    lazy var customizedCongTextfield: CongUITextField = {
        let textfield = CongUITextField()
        textfield.placeholder = "Enter text here"
        textfield.borderStyle = .roundedRect
        textfield.autocorrectionType = .no
        textfield.keyboardType = .default
        textfield.returnKeyType = .done
        textfield.clearButtonMode = .whileEditing
        textfield.contentVerticalAlignment = .center
        textfield.delegate = self
        
        textfield.shouldAddPaddingToClearButton = true

        textfield.setLeftTextView(text: "Cong")
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
        originalTextField.text = ""
        customizedTextField.text = ""
        
        errorTextForNormalTextField.isHidden = false
        errorTextForCustomizedTextField.isHidden = false
        
        errorTextForNormalTextField.text = "Required"
        errorTextForCustomizedTextField.text = "Required"
    }
    func style() {
        originalTextField.translatesAutoresizingMaskIntoConstraints = false
        customizedCongTextfield.translatesAutoresizingMaskIntoConstraints = false
        textFieldWithRightImageView.translatesAutoresizingMaskIntoConstraints = false
        customizedTextField.translatesAutoresizingMaskIntoConstraints = false
        errorTextForNormalTextField.translatesAutoresizingMaskIntoConstraints = false
        errorTextForCustomizedTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        self.view.addSubview(originalTextField)
        self.view.addSubview(customizedTextField)
        self.view.addSubview(textFieldWithRightImageView)
        self.view.addSubview(customizedCongTextfield)
        self.view.addSubview(errorTextForNormalTextField)
        self.view.addSubview(errorTextForCustomizedTextField)
        
        originalTextField.setNeedsLayout()
        originalTextField.layoutIfNeeded()
        
        NSLayoutConstraint.activate([
            
            textFieldWithRightImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.lineSpacer),
            textFieldWithRightImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.lineSpacer),
            
            customizedCongTextfield.topAnchor.constraint(equalTo: textFieldWithRightImageView.safeAreaLayoutGuide.bottomAnchor, constant: 60),

            customizedCongTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.lineSpacer),
            customizedCongTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.lineSpacer),
      
            originalTextField.topAnchor.constraint(equalTo: customizedCongTextfield.safeAreaLayoutGuide.bottomAnchor, constant: 60),
            
            originalTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            originalTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            originalTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.lineSpacer),
            originalTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.lineSpacer),
            
            errorTextForNormalTextField.topAnchor.constraint(equalTo: originalTextField.safeAreaLayoutGuide.bottomAnchor, constant: Constants.lineSpacer),
            errorTextForNormalTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.lineSpacer),
            errorTextForNormalTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.lineSpacer),
            
            customizedTextField.topAnchor.constraint(equalTo: errorTextForNormalTextField.safeAreaLayoutGuide.bottomAnchor, constant: Constants.lineSpacer),
            customizedTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.lineSpacer),
            customizedTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.lineSpacer),
            
            // If needed, we can add height constraint for the textfield here
            
            errorTextForCustomizedTextField.topAnchor.constraint(equalTo: customizedTextField.bottomAnchor, constant: Constants.lineSpacer),
            errorTextForCustomizedTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.lineSpacer),
            errorTextForCustomizedTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.lineSpacer)
            
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

// MARK: - Preview without navigation bar items from UIKit UIViewController
@available(iOS 13, *)
struct BaseUIView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        /// Protocol `UIViewControllerRepresentable` only allows us to load `UIKit view` of `UIViewController`,
        /// but not the navigation bar items from the `UINavigationController`
        ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

@available(iOS 13, *)
struct PreviewBaseUIView: PreviewProvider {
    static var previews: some View {
        BaseUIView()
    }
}
