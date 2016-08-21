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
    
    func createGroup(group : Group, completion : (Bool, NSError?) -> ()) -> Void {
        let pfObject = groupMapper.toPFObject(group)
        groupDao.upsert(pfObject) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
    
    func deleteGroupById(id : String, completion : (Bool, NSError?) -> Void)  {
        groupDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }
    
    
    func getAllGroups(completion : ([Group], NSError?) -> Void) {
        
        groupDao.getAll { (pfObjects : [PFObject]?, error : NSError?) in
            completion(self.groupMapper.groups(pfObjects), error)
        }
    }

    func getGroupsById(completion : ([Group], NSError?) -> Void) {
        
        groupDao.getAll { (pfObjects : [PFObject]?, error : NSError?) in
            completion(self.groupMapper.groups(pfObjects), error)
        }
    }

}
