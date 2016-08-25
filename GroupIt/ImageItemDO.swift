//
//  ImageItemDO.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/24/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class ImageItemDO: PFObject, PFSubclassing {

    @NSManaged var imageItemName : String?
    @NSManaged var imageItemDescription : String?
    @NSManaged var image : PFFile?
    @NSManaged var category : CategoryDO?
    
    static func parseClassName() -> String {
        return Constants.IMAGE_ITEM_CLASSNAME
    }
    
    override init() {
        super.init()
    }
    
    override class func initialize() {
        var onceToken: dispatch_once_t = 0
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
}
