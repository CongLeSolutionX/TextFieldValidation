//
//  CongUIColor.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import UIKit

@objcMembers public class CongUIColor: UIColor {
    public static let bundleID = "tech.CongLeSolutionX.CongUI"
    
    public static override var red: CongUIColor { return self.color(#function) }
    public static override var black: CongUIColor { return self.color(#function) }
    public static override var white: CongUIColor { return self.color(#function) }
    public static override var darkText: CongUIColor { return self.color(#function) }
    
    public static var slate2: CongUIColor { return self.color(#function) }
    public static var blueSuedeShoes: CongUIColor { return self.color(#function) }
    public static var badReligion: CongUIColor { return self.color(#function) }
    
    fileprivate static let colorDictionary = [
        "red": CongUIColor.congUIColor(fromUIColor: UIColor.red),
        "black": CongUIColor.congUIColor(fromUIColor: UIColor.black),
        "white": CongUIColor.congUIColor(fromUIColor: UIColor.white),
        "darkText": CongUIColor.congUIColor(fromUIColor: UIColor.darkText),
        
        "slate2": CongUIColor(red: 221 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1),
        "blueSuedeShoes": CongUIColor(red: 0 / 255, green: 113 / 255, blue: 196 / 255, alpha: 1),
        "badReligion": CongUIColor(red: 102 / 255, green: 102 / 255, blue: 102 / 255, alpha: 1)
    ]
    
    public static func color(_ colorString: String) -> CongUIColor {
        var retval = colorDictionary["black"]!
        if let foundColor = colorDictionary[colorString] {
            retval = foundColor
        }
        return retval
    }

    public static func congUIColor(fromUIColor color: UIColor) -> CongUIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return CongUIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
