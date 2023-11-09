//
//  MyTableViewModel.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/2/23.
//

import UIKit

protocol LoginTextFieldable {
    static var placeholder: String { get }
    static var accessibilityIdentifier: String { get }
    static var leftTextViewText: String { get }
}


class LoginViewModel {
    enum UsernameTextField: LoginTextFieldable {
        static var placeholder: String { "Enter Username"}
        static var accessibilityIdentifier: String { "usernameTextField" }
        static var leftTextViewText: String { "Username" }
    }
    
    static func configureTextField(
        delegate: UITextFieldDelegate,
        textFieldConstants: LoginTextFieldable.Type,
        contentType: UITextContentType,
        returnKeyType: UIReturnKeyType,
        isSecureTextEntry: Bool
    ) -> CongUITextField {
        let textField = CongUITextField()
        textField.placeholder = textFieldConstants.placeholder
        textField.delegate = delegate
        textField.isEnabled = true
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.accessibilityHint = textField.placeholder
        textField.accessibilityIdentifier = textFieldConstants.accessibilityIdentifier
        textField.accessibilityValue = textField.text
        textField.isSecureTextEntry = isSecureTextEntry
        textField.returnKeyType = .next
        textField.textContentType = contentType
        textField.setLeftTextView(text: textFieldConstants.leftTextViewText)
        return textField
    }
}
