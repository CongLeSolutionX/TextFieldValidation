//
//  BaseTableViewCell.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import Foundation
import UIKit

public protocol ReusableInitStyle: UITableViewCell {
    static var reuseIdentifier: String { get }
    func commonInit()
    func set(textLabelValue: String?, detailTextLabelValue: String?)
    func set(attributedTextLabelValue: NSAttributedString?, attributedDetailTextLabelValue: NSAttributedString?)
    func set(textLabelAccessibilityValue: String?, detailTextAccessibilityValue: String?)
}

open class CongBaseTableViewCell: UITableViewCell, ThemeableElement {
    
    public var theme: CongUIThemeBase? = .currentTheme
    public var helpButtonBlock: ((_ sender: UIButton?) -> Void)?
    
    // MARK: - Properties
    public var stringTag: String?
    public var objTag: Any?
    var fakeSeparatorLine: UIView?
    
    open class var reuseIdentifier: String {
        return "cell"
    }
    
    // MARK: - Initializers/Deinitializer
    open func commonInit() {
        objTag = nil
        stringTag = nil
        textLabel?.text = nil
        detailTextLabel?.text = nil
        imageView?.image = nil
        self.enableThemeNotifications(true)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        selectionStyle = .default
        accessibilityIdentifier = "cellLabel"
        textLabel?.accessibilityIdentifier = "textLabel"
        detailTextLabel?.accessibilityIdentifier = "detailedTextLabel"
        textLabel?.numberOfLines = 0
        detailTextLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.minimumScaleFactor = 0.5
        textLabel?.adjustsFontForContentSizeCategory = true
        detailTextLabel?.adjustsFontSizeToFitWidth = true
        detailTextLabel?.minimumScaleFactor = 0.5
        detailTextLabel?.lineBreakMode = .byWordWrapping
        detailTextLabel?.adjustsFontForContentSizeCategory = true
        
        commonInit()
        reloadTheme()
    }
    
    deinit {
        self.enableThemeNotifications(false)
    }
    
    @objc
    open func reloadTheme() {
        self.backgroundColor = self.theme?.tableViewCellBackgroundColor
        self.textLabel?.font = CongUIFont.body
        self.textLabel?.textColor = self.theme?.labelDefaultColor
        self.detailTextLabel?.textColor = self.theme?.labelDetailColor
        self.tintColor = self.theme?.linkColor
        self.selectedBackgroundView = nil
        
        if self.theme == .dark {
            let selectedBackgroundView = UIView(frame: self.frame)
            selectedBackgroundView.backgroundColor = CongUIColor.badReligion
            self.selectedBackgroundView = selectedBackgroundView
        }
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?){
        super.traitCollectionDidChange(previousTraitCollection)
        let preferredContentSizeCategory = self.traitCollection.preferredContentSizeCategory
        
        if previousTraitCollection?.preferredContentSizeCategory != preferredContentSizeCategory {
            self.updateToAccessibilitySize(isAccessibilityCategory: preferredContentSizeCategory.isAccessibilityCategory)
            self.layoutIfNeeded()
        }
    }
    
    open func updateToAccessibilitySize(isAccessibilityCategory: Bool) { }
    
    override open func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority
    ) -> CGSize {
        layoutIfNeeded()
        var size = super.systemLayoutSizeFitting(
            targetSize, withHorizontalFittingPriority:
                horizontalFittingPriority,
            verticalFittingPriority: verticalFittingPriority
        )
        
        size.height += heightToAdd
        return size
    }
    
    private var heightToAdd: CGFloat {
        guard let detailFrame = detailTextLabel?.frame,
              let textFrame = textLabel?.frame,
              detailFrame.height > 0, detailFrame.minY <= textFrame.maxY
        else {
            return 0
        }
        
        // This checks for value1 or value2 styles. It sizes subtitle cells correctly for
        // accessibility font sizes, but not for value1 or value2. -MB
        if detailFrame.minX > textFrame.minX {
            if detailFrame.height > textFrame.height {
                return detailFrame.height - textFrame.height
            }
        }
        return 0
    }
    
    public func enabled(_ yesOrNo: Bool) {
        self.setCellEnabledStatus(enabled: yesOrNo)
    }

    func setCellEnabledStatus(enabled: Bool) {
        self.isUserInteractionEnabled = enabled
        self.textLabel?.isEnabled = enabled
        self.detailTextLabel?.isEnabled = enabled
        if enabled {
            self.accessoryType = .disclosureIndicator
            self.selectionStyle = .default
        } else {
            self.accessoryType = .none
            self.selectionStyle = .none
        }
    }

    public func createLoadingDataDisplay(withLoadingText textToDisplay: String?, indicatorStyle: UIActivityIndicatorView.Style? = nil) {
        self.textLabel?.text = textToDisplay
        self.textLabel?.accessibilityLabel = self.textLabel?.text
        self.textLabel?.textColor = CongUIColor.lightGray
        self.detailTextLabel?.text = nil
        self.isUserInteractionEnabled = false
        let activityView = UIActivityIndicatorView(style: indicatorStyle ?? .medium)
        activityView.startAnimating()
        if textToDisplay != nil {
            self.accessoryView = activityView
        } else {
            self.contentView.addSubview(activityView)
            ConstraintHelper.center(subview: activityView, inside: self)
        }
    }
    
    @available(*, deprecated, message: "Use 'contentView.addBorder' or 'removeSeparatorLine' instead")
    public func addFakeSeparatorLine(_ showIt: Bool) {
        if showIt && fakeSeparatorLine == nil {
            fakeSeparatorLine = UIView()
            if let fakeSeparatorLine = fakeSeparatorLine {
                fakeSeparatorLine.backgroundColor = CongUIThemeBase.isDarkThemeActive && CongUIThemeBase.isLoggedIntoInvest ? 
                self.theme?.tableViewSeparatorColor : CongUIColor.lightGray
                self.addSubview(fakeSeparatorLine)
                ConstraintHelper.set(height: 1.0, of: fakeSeparatorLine, inside: self)
                fakeSeparatorLine.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor).isActive = true
                fakeSeparatorLine.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor).isActive = true
                fakeSeparatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
            }
        } else if !showIt && fakeSeparatorLine != nil {
            fakeSeparatorLine?.removeFromSuperview()
            fakeSeparatorLine = nil
        }
    }
}

// MARK: - ReusableInitStyle
extension CongBaseTableViewCell: ReusableInitStyle {
    public func set(textLabelValue: String?, detailTextLabelValue: String?) {
        self.textLabel?.text = textLabelValue ?? self.textLabel?.text
        self.detailTextLabel?.text = detailTextLabelValue ?? self.detailTextLabel?.text
        self.set(textLabelAccessibilityValue: textLabelValue, detailTextAccessibilityValue: detailTextLabelValue)
    }

    public func set(textLabelAccessibilityValue: String?, detailTextAccessibilityValue: String?) {
        self.textLabel?.accessibilityLabel = textLabelAccessibilityValue ?? self.textLabel?.accessibilityLabel
        self.accessibilityIdentifier = textLabelAccessibilityValue ?? self.accessibilityIdentifier
        self.detailTextLabel?.accessibilityLabel = detailTextAccessibilityValue ?? self.detailTextLabel?.accessibilityLabel
    }

    public func set(attributedTextLabelValue: NSAttributedString?, attributedDetailTextLabelValue: NSAttributedString?) {
        self.textLabel?.attributedText = attributedTextLabelValue ?? self.textLabel?.attributedText
        self.detailTextLabel?.attributedText = attributedDetailTextLabelValue ?? self.detailTextLabel?.attributedText
        self.set(textLabelAccessibilityValue: attributedTextLabelValue?.string, detailTextAccessibilityValue: attributedDetailTextLabelValue?.string)
    }
}

// MARK: - Helper functions
extension CongBaseTableViewCell {
    public func addHelpAccessoryView(helpIcon: UIImage? = #imageLiteral(resourceName: "helpicon"), buttonClick: ((_ sender: UIButton?) -> Void)?) {

        guard let helpIcon = helpIcon else { return }
        let accessoryButton = UIButton(type: .custom)
        accessoryButton.accessibilityLabel = "Help"
        accessoryButton.addTarget(self, action: #selector(self.helpButtonTapped(sender:)), for: .touchUpInside)

        let accessoryImage = helpIcon.withRenderingMode(.alwaysTemplate)
        accessoryButton.setImage(accessoryImage, for: .normal)
        accessoryButton.frame.size = accessoryImage.size
        
        /// TODO: research on this propety `contentEdgeInsets` on iOS 15
        //accessoryButton.contentEdgeInsets = .zero
        //accessoryButton.imageEdgeInsets = .zero

        self.accessoryView = accessoryButton
        self.helpButtonBlock = buttonClick
    }
    
    @objc
    private func helpButtonTapped(sender: UIButton?) {
        guard let selectionBlock = self.helpButtonBlock else {
            return
        }
        selectionBlock(sender)
    }
    
    public func addVeilToCell() {
        let obscuringView: UIView = UIView()
        obscuringView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        obscuringView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(obscuringView)
        
        NSLayoutConstraint.activate([
            obscuringView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            obscuringView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            obscuringView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            obscuringView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }
}
