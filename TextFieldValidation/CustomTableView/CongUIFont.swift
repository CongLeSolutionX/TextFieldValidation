//
//  CongUIFont.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//


import UIKit

/// Doc: https://developer.apple.com/design/human-interface-guidelines/typography
public class CongUIFont: UIFont {
    
    static private let fontStyles: [String: UIFont] = [
        "Headline": CongUIFont.headline,
        "Subheadline": CongUIFont.subheadline,
        "Subheadline-Bold": CongUIFont.subheadline.bold(),
        "Footnote-Bold": CongUIFont.footnote.bold(),
        "Body": CongUIFont.body,
        "Title": CongUIFont.title1,
        "Title2": CongUIFont.title2,
        "Title3": CongUIFont.title3,
        "Title3-Bold": CongUIFont.title3.bold(),
        "HugeBody": CongUIFont.body.withSize(25),
        "HugeHeadline": CongUIFont.headline.withSize(40),
        "HugeTitle": CongUIFont.title1.withSize(100),
        "HugeTitle2": CongUIFont.title2.withSize(100),
        "HugeTitle3": CongUIFont.title3.withSize(100)
    ]
    
    static public func fontFrom(name nameStr: String) -> UIFont {
         return fontStyles[nameStr] ?? CongUIFont.body
     }

    public enum MaxPointSizes: CGFloat {
        case cardNumberFont = 31
        case cardDateFont = 23
    }
    

    @objc
    public static func getFont(font: UIFont, withSize: CGFloat) -> UIFont {
        return UIFont(descriptor: font.fontDescriptor, size: withSize)
    }

    @objc
    @available(*, deprecated, message: "Use the bold() extension of UIFont instead")
    public static func boldVersion(of font: UIFont) -> UIFont {
        guard let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitBold) else {
            return font
        }
        return UIFont(descriptor: fontDescriptor, size: 0)
    }

    @objc
    @available(*, deprecated, message: "Use the italicize() extension of UIFont instead")
    public static func italicizedVersion(of font: UIFont) -> UIFont {
        guard let fontDescriptor = font.fontDescriptor.withSymbolicTraits(.traitItalic) else {
            return font
        }
        return UIFont(descriptor: fontDescriptor, size: 0)
    }

    private static func restrictMaxFontSize(_ fontStyle: UIFont.TextStyle, _ maxSize: CGFloat) -> UIFont {
        let fontMetrics = UIFontMetrics(forTextStyle: fontStyle)
        let font = UIFont.preferredFont(forTextStyle: fontStyle)
        return fontMetrics.scaledFont(for: font, maximumPointSize: maxSize)
    }

    @objc
    public static var largeTitle: UIFont {
        // Large(Default) 34
        // xxxLarge 40
        return self.restrictMaxFontSize(.largeTitle, 40)
    }

    @objc
    public static var title1: UIFont {
        // Large (Default) 28
        // xxxLarge 34
        return self.restrictMaxFontSize(.title1, 34)
    }
    
    @objc
    public static var title2: UIFont {
        // Large(Default) 22
        // xxxLarge 28
        return restrictMaxFontSize(.title2, 28)
    }

    @objc
    public static var title3: UIFont {
        // Large(Default) 20
        // xxxLarge 26
        return restrictMaxFontSize(.title3, 26)
    }

    @objc
    public static var body: UIFont {
        // Large(Default) 17
        // xxxLarge 23
        return restrictMaxFontSize(.body, 23)
    }

    @objc
    public static var headline: UIFont {
        // Large(Default) 17
        // xxxLarge 23
        return restrictMaxFontSize(.headline, 23)
    }

    @objc
    public static var subheadline: UIFont {
        // Large(Default) 15
        // xxxLarge 21
        return restrictMaxFontSize(.subheadline, 21)
    }

    @objc
    public static var footnote: UIFont {
        // Large(Default) 13
        // xxxLarge 19
        return restrictMaxFontSize(.footnote, 19)
    }

    @objc
    public static var caption1: UIFont {
        // Large(Default) 12
        // xxxLarge 18
        return restrictMaxFontSize(.caption1, 18)
    }

    @objc
    public static var caption2: UIFont {
        // Large(Default) 11
        // xxxLarge 17
        return restrictMaxFontSize(.caption2, 17)
    }
}

// MARK: - UIFont
public extension UIFont {
    internal func modifyFont(symbolicTraits: UIFontDescriptor.SymbolicTraits, size: CGFloat? = 0) -> UIFont {
        guard let fontDescriptor = self.fontDescriptor.withSymbolicTraits(symbolicTraits) else {
            return self
        }
        return UIFont(descriptor: fontDescriptor, size: size ?? 0)
    }
    
    internal func modifyFont(systemDesign: UIFontDescriptor.SystemDesign, size: CGFloat? = 0) -> UIFont {
        guard let fontDescriptor = self.fontDescriptor.withDesign(systemDesign) else {
            return self
        }
        return UIFont(descriptor: fontDescriptor, size: size ?? 0)
    }
    
    @objc func bold() -> UIFont {
        return self.modifyFont(symbolicTraits: .traitBold, size: self.fontDescriptor.pointSize)
    }
    
    @objc func italicize() -> UIFont {
        return self.modifyFont(symbolicTraits: .traitItalic, size: self.fontDescriptor.pointSize)
    }
    
    @objc func size(_ size: CGFloat) -> UIFont {
        return self.modifyFont(symbolicTraits: self.fontDescriptor.symbolicTraits, size: size)
    }
    
    @objc func rounded() -> UIFont {
        return self.modifyFont(systemDesign: .rounded, size: self.fontDescriptor.pointSize)
    }
}
