//
//  CongUITextField.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/2/23.
//


import UIKit

open class CongUITextField: UITextField, ThemeableElement {
    public var theme: CongUIThemeBase? = .currentTheme
    var textFieldIdentifier: String = ""
    
    open var shouldAddPaddingToClearButton: Bool = false
    
    override open var placeholder: String? {
        didSet {
            self.reloadTheme()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.keyboardType = .asciiCapable
        self.enableThemeNotifications(true)
        self.reloadTheme()
    }
    
    deinit {
        self.enableThemeNotifications(false)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        // Common calculations
        let clearButtonWidth = clearButtonMode != .never ? clearButtonRect(forBounds: bounds).width : 0
        let padding: CGFloat = 5 // Padding from text to clearButton

        if shouldAddPaddingToClearButton && clearButtonMode != .never && isEditing {
            // If editing and padding is needed, adjust the text rect
            var textRect = super.textRect(forBounds: bounds)
            textRect.size.width -= (clearButtonWidth + padding)
            return textRect
        } else {
            // The default case must respect both the leftView and clear button without additional padding
            let leftViewWidth = leftViewRect(forBounds: bounds).size.width
            let originX = layoutMargins.left + leftViewWidth
            let width = bounds.size.width - originX - clearButtonWidth - (clearButtonWidth > 0 ? layoutMargins.right : 0)
            return CGRect(x: originX, y: 0, width: width, height: bounds.size.height)
        }
    }
   
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var clearButtonRect = super.clearButtonRect(forBounds: bounds)
        if shouldAddPaddingToClearButton {
            /// Move the button to the left by subtracting 20 points from the x-coordinate
            /// This effectively adds 20 points padding to the right edge of the button
            clearButtonRect.origin.x -= 20
        }
        return clearButtonRect
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonWidth = self.clearButtonRect(forBounds: bounds).width
        let padding: CGFloat = 5 // Padding from text to clearButton
        
        // Regardless of the padding flag, when not editing, use the same rect as textRect.
        // This ensures consistency in appearance between the editing and non-editing states.
        var editingRect = super.editingRect(forBounds: bounds)
        
        // When editing, consider the clear button width and padding only if shouldAddPaddingToClearButton is true.
        if shouldAddPaddingToClearButton && clearButtonMode != .never && self.isEditing {
            // Adjust the width to account for the clear button width and desired padding
            editingRect.size.width -= (clearButtonWidth + padding)
        }
        return editingRect
    }
    
    public func setLeftTextView(
        text: String,
        textColor: UIColor? = nil,
        textFont: UIFont? = nil,
        isLeftLabelAccessible: Bool = true,
        leftLabelAccessibilityText: String? = nil,
        shouldAddLeadingSpace: Bool = true
    ) {
        let textFieldTextView = UILabel(frame: CGRect())
        textFieldTextView.text = String(format: "%@%@", shouldAddLeadingSpace ? " " : "", text)
        textFieldTextView.font = textFont // Assuming AllyUIFont.body is the default font you want to use
        textFieldTextView.textAlignment = .left
        textFieldTextView.textColor = self.theme?.labelDetailColor
        if let textColor = textColor {
            textFieldTextView.textColor = textColor
        }
        textFieldTextView.sizeToFit()
        textFieldTextView.accessibilityLabel = leftLabelAccessibilityText ?? "\(text) Text Field" // Assuming "localized" is a string extension you have
        textFieldTextView.isAccessibilityElement = isLeftLabelAccessible
        self.leftView = textFieldTextView
        self.leftViewMode = .always
    }
    
    open func reloadTheme() {
        self.keyboardAppearance = self.theme?.keyboardAppearance ?? .light
        self.tintColor = self.theme?.labelDefaultColor
        self.textColor = self.theme?.labelDefaultColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes:
            [NSAttributedString.Key.foregroundColor: self.theme?.textFieldPlaceholderColor ?? UIColor.lightGray])
    }
}
