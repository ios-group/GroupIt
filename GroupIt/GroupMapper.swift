//
//  GroupMapper.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class GroupMapper: NSObject {
        
    func toPFObject(group : Group) -> PFObject {
        let groupPFObject = PFObject(className: Constants.GROUP_CLASSNAME)
        groupPFObject.objectId = group.groupId
        groupPFObject["groupName"] = group.groupName
        groupPFObject["groupDescription"] = group.groupDescription

        return groupPFObject
    }
    
    func groups(pfObjects : [PFObject]?) -> [Group] {
        var groups : [Group] = []
        if let pfObjects = pfObjects {
            for pfObject in pfObjects {
                groups.append(group(pfObject)!)
            }
        }
        return groups
    }

    func group(pfObject: PFObject?) -> Group? {
        var groupDictionary : Dictionary<String, AnyObject> = [:]
        if let pfObject = pfObject {
            
            groupDictionary["groupId"] = pfObject.objectId
            groupDictionary["groupName"] = pfObject.objectForKey("groupName") as! String
            groupDictionary["groupDescription"] = pfObject.objectForKey("groupDescription") as! String
        }
        return Group(groupDictionary: groupDictionary)
    }
}
