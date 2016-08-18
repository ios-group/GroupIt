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
    
    func upsertTodoCategory(todoCategory : TodoCategory, completion : (Bool, NSError?) -> ()) -> Void {
        let todoCategoryDO = todoCategoryMapper.toTodoCategoryDO(todoCategory)
        todoCategoryDao.upsert(todoCategoryDO) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
    
    func deleteTodoCategoryById(id : String, completion : (Bool, NSError?) -> Void)  {
        todoCategoryDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }

    func getAllTodoCategories(completion : ([TodoCategory], NSError?) -> Void) {
        var todoCategories : [TodoCategory] = []
        todoCategoryDao.getAll { (todoCategoryPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoCategoryPfObjects = todoCategoryPfObjects {
                    for todoCategoryPfObject in todoCategoryPfObjects {
                        let todoCategory = self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! TodoCategoryDO)
                        todoCategories.append(todoCategory)
                    }
                }
            }
            completion(todoCategories, error)
        }
    }
    
    func getAllTodoCategoriesByGroupId(completion : ([TodoCategory], NSError?) -> Void) {
        var todoCategories : [TodoCategory] = []
        todoCategoryDao.getAllByForeignKey { (todoCategoryPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoCategoryPfObjects = todoCategoryPfObjects {
                    for todoCategoryPfObject in todoCategoryPfObjects {
                        todoCategories.append(self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! TodoCategoryDO))
                    }
                }
            }
            completion(todoCategories, error)
        }
    }

    func getTodoCategoryById(id : String, completion : (todoCategory : TodoCategory?, error : NSError?) -> Void) {
        todoCategoryDao.getById(id) { (todoCategoryPfObject: PFObject?, error : NSError?) in
            let todoCategory = self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! TodoCategoryDO)
            completion(todoCategory: todoCategory, error: error)
        }
    }
    
}
