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
    
    
    public static var badReligion: CongUIColor { return self.color(#function) }
    
    fileprivate static let colorDictionary = [
        "black": CongUIColor.congUIColor(fromUIColor: UIColor.black),
        
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
