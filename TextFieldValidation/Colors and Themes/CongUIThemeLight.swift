//
//  CongUIThemeLight.swift
//  TextFieldValidation
//
//  Created by CONG LE on 11/2/23.
//

class CongUIThemeLight: CongUIThemeBase {
    required public init() {
        super.init()
        
        // Define the key/value pairs for colorNameDictionary here
        colorNameDictionary = [
            "tableViewCellBackgroundColor": CongUIColor.white,
            "tableViewSeparatorColor": CongUIColor.slate2,
            "linkColor": CongUIColor.blueSuedeShoes,
            "labelDetailColor" : CongUIColor.badReligion,
            "labelDefaultColor": CongUIColor.darkText,
            
            "textFieldPlaceholderColor": CongUIColor.lightGray
        ]
    }
}
