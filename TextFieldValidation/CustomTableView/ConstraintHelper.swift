//
//  AllyConstraintHelper.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import UIKit

public class ConstraintHelper: NSObject {
    
    @objc public static func setConstraint(for firstView: UIView, firstViewAttribute: NSLayoutConstraint.Attribute, equalTo secondView: UIView!, secondViewAttribute: NSLayoutConstraint.Attribute, superView: UIView, insetBy inset: CGFloat) {
        self.setConstraint(for: firstView, firstViewAttribute: firstViewAttribute, equalTo: secondView, secondViewAttribute: secondViewAttribute, superView: superView, insetBy: inset, multiplier: 1.0, relatedBy: .equal)
    }

    @objc public static func setConstraint(for firstView: UIView, firstViewAttribute: NSLayoutConstraint.Attribute, equalTo secondView: UIView, secondViewAttribute: NSLayoutConstraint.Attribute, superView: UIView!, insetBy inset: CGFloat, multiplier multi: CGFloat, relatedBy related: NSLayoutConstraint.Relation) {

        guard superView != nil, firstView != nil else { return }

        if superView.subviews.contains(firstView) {
            firstView.translatesAutoresizingMaskIntoConstraints = false

            let layoutConstraint = NSLayoutConstraint(item: firstView, attribute: firstViewAttribute, relatedBy: related, toItem: secondView, attribute: secondViewAttribute, multiplier: multi, constant: inset)

            superView.addConstraint(layoutConstraint)
        }
    }
    
    @objc public static func set(height: CGFloat, of subview: UIView!, inside superview: UIView!) {
        self.setConstraint(for: subview, firstViewAttribute: .height, equalTo: nil, secondViewAttribute: .height, superView: superview, insetBy: height)
    }
    
    @objc public static func center(subview: UIView!, inside superview: UIView!) {
        self.horizontallyCenter(subview: subview, inside: superview)
        self.verticallyCenter(subview: subview, inside: superview)
    }
    
    @objc public static func horizontallyCenter(subview: UIView!, inside superview: UIView!) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    @objc public static func verticallyCenter(subview: UIView!, inside superview: UIView!, insetBy inset: CGFloat = 0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: inset).isActive = true
    }
}
