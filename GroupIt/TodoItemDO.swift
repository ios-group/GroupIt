//
//  TodoItemDO.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class TodoItemDO : PFObject, PFSubclassing {

    @NSManaged var id : String?
    @NSManaged var todoItemName : String?
    var completed : Bool?
    @NSManaged var category : TodoCategoryDO?
    
    static func parseClassName() -> String {
        return Constants.TODO_ITEM_CLASSNAME
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
