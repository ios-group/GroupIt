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
        groupDao.create(pfObject) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
    
//    func updateGroup(id : String, todoCategory : TodoCategory, completion : (Bool, NSError?) -> Void) {
//        let pfObjectNew = todoCategoryMapper.toPFObject(todoCategory)
//        todoCategoryDao.updateById(id, pfObjectNew: pfObjectNew) { (updated : Bool, error : NSError?) in
//            completion(updated, error)
//        }
//    }
    
//    func getAllGroups(completion : ([TodoCategory], NSError?) -> Void) {
//        todoCategoryDao.getAll { (pfObjects : [PFObject]?, error : NSError?) in
//            completion(self.todoCategoryMapper.toTodoCategories(pfObjects), error)
//        }
//    }
    
//    func getGroupById(id : String, completion : (todoCategory : TodoCategory?, error : NSError?) -> Void) {
//        todoCategoryDao.getById(id) { (pfObject: PFObject?, error : NSError?) in
//            completion(todoCategory: self.todoCategoryMapper.toTodoCategory(pfObject), error: error)
//        }
//    }
    
//    func deleteGroupById(id : String, completion : (Bool, NSError?) -> Void)  {
//        todoCategoryDao.deleteById(id) { (deleted : Bool, error : NSError?) in
//            completion(deleted, error)
//        }
//    }

}
