//
//  TextFieldTheme.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/31/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class TextFieldTheme: NSObject {

    static func beautifyTextField(textField : UITextField, placeHolder : String?) {
        textField.setBottomBorder()
        textField.backgroundColor = UIColor.clearColor()
        textField.textColor = UIColor.whiteColor()
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder ?? "", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
}
