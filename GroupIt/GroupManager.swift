//
//  GroupCategoryManager.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class GroupManager: NSObject {
    
    let groupDao = ParseDAO(className: Constants.GROUP_CLASSNAME)
    let groupMapper = GroupMapper()
    
    func upsertGroup(group : Group, completion : (Bool, Group, NSError?) -> ()) -> Void {
        let groupDO = self.groupMapper.toGroupDO(group)
        groupDao.upsert(groupDO) { (created : Bool, pfObject : PFObject?, error : NSError?) in
            let group = self.groupMapper.toGroup(pfObject as! GroupDO)
            completion(created, group, error)
        }
    }
    
    func deleteGroupById(id : String, completion : (Bool, NSError?) -> Void)  {
        groupDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }
    
    
    func getAllGroups(completion : ([Group], NSError?) -> Void) {
        var groups : [Group] = []
        groupDao.getAll { (groupPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let groupPfObjects = groupPfObjects {
                    for groupPfObject in groupPfObjects {
                        groups.append(self.groupMapper.toGroup(groupPfObject as! GroupDO))
                    }
                }
            }
            completion(groups, error)
        }
    }
}
