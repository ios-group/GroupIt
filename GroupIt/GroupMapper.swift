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
    
    var userMapper = UserMapper()
    
    func toGroupDO(group : Group) -> GroupDO {
        let groupDO = GroupDO()
        groupDO.objectId = group.groupId
        groupDO["groupName"] = group.groupName
        groupDO["groupDescription"] = group.groupDescription
        groupDO["groupOwner"] = self.userMapper.toUserDO(group.groupOwner!)
 
        return groupDO
    }
    
    func toGroup(groupDO : GroupDO) -> Group {
        print(groupDO["groupOwner"])
        var groupDictionary = Dictionary<String, AnyObject?>()
        groupDictionary["groupId"] = groupDO.objectId
        groupDictionary["groupName"] = groupDO["groupName"]
        groupDictionary["groupDescription"] = groupDO.groupDescription
        groupDictionary["groupOwner"] = self.userMapper.toUser(groupDO.groupOwner)
        let group = Group(groupDictionary: groupDictionary)
        
        return group
    }
}
