//
//  GroupUserRelationDO.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/29/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class GroupUserRelationDO: PFObject, PFSubclassing {

    @NSManaged var group : GroupDO?
    @NSManaged var user : UserDO?
    
    static func parseClassName() -> String {
        return Constants.GROUP_USER_RELATION_CLASSNAME
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
