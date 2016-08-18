//
//  TodoCategoryManager.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class TodoCategoryManager: NSObject {

    let todoCategoryDao = ParseDAO(className: Constants.TODO_CATEGORY_CLASSNAME)
    let todoCategoryMapper = TodoCategoryMapper()
    
    func createTodoCategory(todoCategory : TodoCategory, completion : (Bool, NSError?) -> ()) -> Void {
        let pfObject = todoCategoryMapper.toPFObject(todoCategory)
        todoCategoryDao.create(pfObject) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
    
    func updateTodoCategory(id : String, todoCategory : TodoCategory, completion : (Bool, NSError?) -> Void) {
        let pfObjectNew = todoCategoryMapper.toPFObject(todoCategory)
        todoCategoryDao.updateById(id, pfObjectNew: pfObjectNew) { (updated : Bool, error : NSError?) in
            completion(updated, error)
        }
    }
    
    func getAllTodoCategories(completion : ([TodoCategory], NSError?) -> Void) {
        todoCategoryDao.getAll { (pfObjects : [PFObject]?, error : NSError?) in
            completion(self.todoCategoryMapper.toTodoCategories(pfObjects), error)
        }
    }
    
    func getTodoCategoryById(id : String, completion : (todoCategory : TodoCategory?, error : NSError?) -> Void) {
        todoCategoryDao.getById(id) { (pfObject: PFObject?, error : NSError?) in
            completion(todoCategory: self.todoCategoryMapper.toTodoCategory(pfObject), error: error)
        }
    }
    
    func deleteTodoCategoryById(id : String, completion : (Bool, NSError?) -> Void)  {
        todoCategoryDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }
    
    func deleteAllCategories(completion : (NSError?) -> Void) {
        todoCategoryDao.deleteAll { (error: NSError?) in
            completion(error)
        }
    }
}
