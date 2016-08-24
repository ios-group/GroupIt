//
//  UserDO.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/23/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class UserDO: PFUser {
    
    @NSManaged var id : String?
    
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
