//
//  ButtonTheme.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/31/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

extension UIButton
{
    func setButtonBorder()
    {
        self.layer.cornerRadius = 2;
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColor.whiteColor().CGColor
    }
}

extension UITextField
{
    func setBottomBorder()
    {
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}