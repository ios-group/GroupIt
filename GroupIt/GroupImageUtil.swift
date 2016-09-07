//
//  GroupImageUtil.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 9/6/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupImageUtil: NSObject {

    static var groupImages : [String] = ["group-image-1","group-image-2","group-image-3","group-image-4"
    ,"group-image-5","group-image-6","group-image-7","group-image-8","group-image-9"]

    static var groupImages2 : [String] = ["1","2","3","4","5","6","7","8","9"]

    static func getGroupImage(index : Int) -> UIImage? {
        let modIndex = index % 9
        return UIImage(named: groupImages2[modIndex])
    }
    
    static func getAddImage() -> UIImage? {
        let addItemImage = "add-image-24-24"
        return UIImage(named : addItemImage)
    }
}
