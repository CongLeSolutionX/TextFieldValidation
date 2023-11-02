//
//  ThemeableElement.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/1/23.
//

import Foundation

@objc public protocol ThemeableElement {
    @objc var theme: CongUIThemeBase? { get set }
    @objc func reloadTheme()
}

// MARK: - Implementation
extension ThemeableElement {
    public func enableThemeNotifications(_ enable: Bool) {
        let notificationName = Notification.Name(CongUIThemeBase.kSettingsThemeChangedNotification)
        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
        
        if enable == true {
            NotificationCenter.default.addObserver(
                forName: notificationName,
                object: nil,
                queue: nil
            ) { [weak self] (notification: Notification) in
                if let updatedTheme = notification.userInfo?["theme"] as? CongUIThemeBase {
                    self?.updateTheme(updatedTheme)
                }
            }
        }
    }
    
    public func updateTheme(_ theme: CongUIThemeBase?) {
        if let fromTheme = self.theme, fromTheme.allowsThemeChange == true {
            self.updateAndReloadTheme(theme: theme)
        }
    }
    
    public func updateAndReloadTheme(theme: CongUIThemeBase?) {
        if let theme = theme {
            #if DEBUG
            print("THEME CHANGE: updating \(self) from \(String(describing: self.theme)) to theme \(String(describing: theme))")
            #endif
            self.theme = theme
            self.reloadTheme()
        }
    }
}
