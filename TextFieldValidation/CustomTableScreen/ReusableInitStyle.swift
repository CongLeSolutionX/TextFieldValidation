//
//  ReusableInitStyle.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/2/23.
//

import UIKit

public protocol ReusableInitStyle: UITableViewCell {
    static var reuseIdentifier: String { get }
    func commonInit()
    func set(textLabelValue: String?, detailTextLabelValue: String?)
    func set(attributedTextLabelValue: NSAttributedString?, attributedDetailTextLabelValue: NSAttributedString?)
    func set(textLabelAccessibilityValue: String?, detailTextAccessibilityValue: String?)
}
