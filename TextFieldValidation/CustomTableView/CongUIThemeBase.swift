//
//  AllyUITheme.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import Foundation
import UIKit

class CongUIThemeLight: CongUIThemeBase {
    required public init() {
        super.init()
        // define the value/key for colorNameDictionary here
    }
}

class CongUIThemeDark: CongUIThemeBase {
    required public init() {
        super.init()
        // define the value/key for colorNameDictionary here
    }
}


@objcMembers
open class CongUIThemeBase: NSObject {
    static public let kSettingsThemeChangedNotification = "ThemeSettingChanged"
    static public var defaultsKey = "AllyCurrentTheme"
    static var light: CongUIThemeBase { return theme(themeString: "light", creator: CongUIThemeLight.self) }
    static var dark: CongUIThemeBase { return theme(themeString: "dark", creator: CongUIThemeDark.self) }
    
    var colorNameDictionary: [String: CongUIColor]
    
    public var themeName: String { return "***Default***"}
    
    public var allowsThemeChange:  Bool { return true }
    static public var darkThemeOverride = false
    
    fileprivate static var defaultTheme = CongUIThemeBase()
    fileprivate static var themeDictionary = [String: CongUIThemeBase]()
    
    static public var isDarkThemeActive: Bool {
        return currentTheme == self.dark
    }
    
    
    static var currentlyUsedTheme = defaultTheme {
        didSet {
            if oldValue != currentlyUsedTheme {
                UserDefaults.standard.set(self.currentlyUsedTheme.themeName, forKey: self.defaultsKey)
            }
        }
    }
    
    static public var isLoggedIntoInvest = false {
        didSet {
            if oldValue != isLoggedIntoInvest {
                self.postNotificationForThemeChange(theme: self.currentTheme)
            }
        }
    }
    
    static public var currentTheme: CongUIThemeBase {
        get {
            if self.darkThemeOverride {
                return self.light
            } else if self.isLoggedIntoInvest {
                return .currentlyUsedTheme
            } else {
                return self.light
            }
        }
        set(newTheme) {
            currentlyUsedTheme = newTheme
        }
    }
    
    fileprivate func color(_ colorString: String) -> CongUIColor {
        var retval = CongUIColor.red
        if let foundColor = colorNameDictionary[colorString] {
            retval = foundColor
        } else {
            assertionFailure("\(colorString) is missing in theme: \(self)")
        }
        return retval
    }
    
    override required public init() {
        colorNameDictionary = [String: CongUIColor]()
        super.init()
    }
    
    public static func postNotificationForThemeChange(theme: CongUIThemeBase) {
        let userInfo = ["theme": theme]
        NotificationCenter.default.post(name: Notification.Name(kSettingsThemeChangedNotification), object: nil, userInfo: userInfo)
    }
    
    static func theme(themeString: String, creator: CongUIThemeBase.Type?) -> CongUIThemeBase {
        var retval = defaultTheme
        if let foundTheme = themeDictionary[themeString] {
            retval = foundTheme
        } else {
            if let creatorClass = creator {
                retval = creatorClass.init()
                themeDictionary[themeString] = retval
            }
        }
        return retval
    }
}

// MARK: - Color for each UI element
extension CongUIThemeBase {
    public var tableViewSeparatorColor: CongUIColor { return self.color(#function) }
    public var tableViewCellBackgroundColor: CongUIColor { return self.color(#function) }
    
    public var linkColor: CongUIColor { return self.color(#function) }
    public var labelDetailColor: CongUIColor { return self.color(#function) }
    public var labelDefaultColor: CongUIColor { return self.color(#function) }
}
