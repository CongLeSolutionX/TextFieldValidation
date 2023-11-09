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
        // We have to give padding between the text and the clear button, if the clear button is present.
        let clearButtonPadding: CGFloat = self.clearButtonMode != .never ? self.layoutMargins.left : 0
        let originX: CGFloat = self.layoutMargins.left + self.leftViewRect(forBounds: bounds).size.width
        let width = bounds.size.width - originX - self.clearButtonRect(forBounds: bounds).size.width - clearButtonPadding
        return CGRect(
            x: originX,
            y: 0,
            width: width, height: bounds.size.height
        )
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
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

class LoginTextField: CongUITextField {
    
    open var shouldAddPaddingToClearButton: Bool = false
    
    override func commonInit() {
        super.commonInit()
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        // Calculate the width of the left view
        let leftViewWidth = self.leftViewRect(forBounds: bounds).size.width
        // Get the starting x coordinate for the text field content from the left view and left margin
        let originX = self.layoutMargins.left + leftViewWidth
        
        // Determine the clear button's width if it should be considered
        let clearButtonWidth = self.clearButtonMode != .never ? clearButtonRect(forBounds: bounds).width : 0
        // Calculate the needed padding if the clear button is visible
        let padding: CGFloat = (clearButtonWidth > 0 && self.shouldAddPaddingToClearButton) ? 14 : 0
        
        // Calculate the updated width of the text field content by subtracting the left side widths (left view + margins)
        // and the right side widths (clear button + padding + margins if clear button is visible)
        let width = bounds.width - originX - clearButtonWidth - padding - (clearButtonWidth > 0 ? self.layoutMargins.right : 0)
        
        // Return the updated text rectangle
        return CGRect(x: originX, y: 0, width: max(0, width), height: bounds.height)
    }
    
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var clearButtonRect = super.clearButtonRect(forBounds: bounds)
        if self.shouldAddPaddingToClearButton {
            /// Move the button to the left by subtracting 12 points from the x-coordinate
            /// This effectively adds 12 points padding to the right edge of the button
            clearButtonRect.origin.x -= 12
        }
        return clearButtonRect
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
}
