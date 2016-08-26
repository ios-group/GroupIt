//
//  TodoCategoryDO.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class CategoryDO : PFObject, PFSubclassing {
    
    @NSManaged var categoryId : String?
    @NSManaged var categoryName : String?
    @NSManaged var categoryDescription : String?
    @NSManaged var categoryType : String?
    @NSManaged var group : GroupDO?
    
    static func parseClassName() -> String {
        return Constants.TODO_CATEGORY_CLASSNAME
    }
    
    override init() {
        super.init()
    }
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
}
