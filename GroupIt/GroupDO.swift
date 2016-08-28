//
//  GroupDO.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class GroupDO : PFObject, PFSubclassing {

    @NSManaged var id : String?
    @NSManaged var groupName : String?
    @NSManaged var groupDescription : String?
    @NSManaged var groupOwner : UserDO

    static func parseClassName() -> String {
        return Constants.GROUP_CLASSNAME
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
