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

    let groupDao = ParseDAO(className: Constants.GROUP_CLASSNAME)
    
    let todoCategoryDao = ParseDAO(className: Constants.TODO_CATEGORY_CLASSNAME)
    let todoCategoryMapper = TodoCategoryMapper()

    func upsertTodoCategory(groupId : String, todoCategory : Category, completion : (Bool, Category?, NSError?) -> ()) -> Void {
        groupDao.getById(groupId) { (groupPfObject : PFObject?, error : NSError?) in
            if error == nil {
                let todoCategoryDO = self.todoCategoryMapper.toTodoCategoryDO(groupPfObject as! GroupDO, todoCategory: todoCategory)
                self.todoCategoryDao.upsert(todoCategoryDO, completion: { (upserted : Bool, pfObject : PFObject?, error : NSError?) in
                    let category = self.todoCategoryMapper.toTodoCategory(pfObject as! CategoryDO)
                    completion(upserted, category, error)
                })
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func deleteTodoCategoryById(id : String, completion : (Bool, NSError?) -> Void)  {
        todoCategoryDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }

    func getAllTodoCategories(completion : ([Category], NSError?) -> Void) {
        var todoCategories : [Category] = []
        todoCategoryDao.getAll { (todoCategoryPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoCategoryPfObjects = todoCategoryPfObjects {
                    for todoCategoryPfObject in todoCategoryPfObjects {
                        let todoCategory = self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! CategoryDO)
                        todoCategories.append(todoCategory)
                    }
                }
            }
            completion(todoCategories, error)
        }
    }
    
    func getAllTodoCategoriesByGroupId(groupId : String, completion : ([Category], NSError?) -> Void) {
        var todoCategories : [Category] = []
        let parseContext = ParseContext(className: "TodoCategory")
        parseContext.className = Constants.TODO_CATEGORY_CLASSNAME
        parseContext.predicateFormat = "group IN %@"
        parseContext.innerClassName = Constants.GROUP_CLASSNAME
        parseContext.innerPredicateFormat = "objectId = '\(groupId)'"
        todoCategoryDao.getAllByForeignKey(parseContext) { (todoCategoryPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoCategoryPfObjects = todoCategoryPfObjects {
                    for todoCategoryPfObject in todoCategoryPfObjects {
                        todoCategories.append(self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! CategoryDO))
                    }
                }
            }
            completion(todoCategories, error)
        }
    }

    func getTodoCategoryById(id : String, completion : (todoCategory : Category?, error : NSError?) -> Void) {
        todoCategoryDao.getById(id) { (todoCategoryPfObject: PFObject?, error : NSError?) in
            let todoCategory = self.todoCategoryMapper.toTodoCategory(todoCategoryPfObject as! CategoryDO)
            completion(todoCategory: todoCategory, error: error)
        }
    }
    
    func deleteAllCategories(completion : (NSError?) -> Void) {
        todoCategoryDao.deleteAll { (error: NSError?) in
            completion(error)
        }
    }
}
