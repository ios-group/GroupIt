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
        
    func toGroupDO(group : Group) -> GroupDO {
        let groupDO = GroupDO()
        groupDO.objectId = group.groupId
        groupDO["groupName"] = group.groupName
        return groupDO
    }
    
    func toGroup(groupDO : GroupDO) -> Group {
        var groupDictionary = Dictionary<String, AnyObject?>()
        groupDictionary["groupId"] = groupDO.objectId
        groupDictionary["groupName"] = groupDO["groupName"]
        let group = Group(groupDictionary: groupDictionary)
        return group
    }
  
    
}
