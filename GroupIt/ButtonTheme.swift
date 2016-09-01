//
//  ButtonTheme.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/31/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ButtonTheme: NSObject {

    static func beautifyButton(button : UIButton) {
        button.setButtonBorder()
        button.tintColor = UIColor.whiteColor()
    }
}
