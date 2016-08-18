//
//  GroupDataUtil.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class GroupDataUtil: NSObject {

    func createGroup() -> Group {
        return createGroup("group-1")
    }
    
    func createGroup(groupName : String) -> Group {
        var groupDictionary : Dictionary<String, AnyObject> = [:]
//        groupDictionary["groupId"] = "1"
        groupDictionary["groupName"] = groupName
        groupDictionary["groupDescription"] = "This is the First Group"
        return Group(groupDictionary: groupDictionary)
    }
}
