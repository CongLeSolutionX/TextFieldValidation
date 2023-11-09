//
//  CustomizedTextField.swift
//  TextFieldValidation
//
//  Created by Cong Le on 3/6/22.
//

import UIKit

class CustomizedTextField: UITextField {
    public func setLeftTextView(
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
