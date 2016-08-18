//
//  TodoItemManager.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/14/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class TodoItemManager: NSObject {

    let todoCategoryDao = ParseDAO(className: Constants.TODO_CATEGORY_CLASSNAME)
    let todoItemDao = ParseDAO(className: Constants.TODO_ITEM_CLASSNAME)

    let todoItemMapper = TodoItemMapper()
    let todoCategoryMapper = TodoCategoryMapper()
    
    func upsertTodoItem(categoryId : String, todoItem : TodoItem, completion : (Bool, NSError?) -> ()) -> Void {
        todoCategoryDao.getById(categoryId) { (todoCategoryPfObject : PFObject?, error : NSError?) in
            if error == nil {
                let todoItemDO = self.todoItemMapper.toTodoItemDO(todoCategoryPfObject as! TodoCategoryDO, todoItem: todoItem)
                self.todoItemDao.upsert(todoItemDO) { (created : Bool, error : NSError?) in
                    completion(created, error)
                }
            } else {
                completion(false, error)
            }
        }
    }

    func deleteTodoItemById(id : String, completion : (Bool, NSError?) -> Void)  {
        todoItemDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }

    func getAllTodoItems(completion : ([TodoItem], NSError?) -> Void) {
        var todoItems : [TodoItem] = []
        todoItemDao.getAll { (todoItemPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoItemPfObjects = todoItemPfObjects {
                    for todoItemPfObject in todoItemPfObjects {
                        todoItems.append(self.todoItemMapper.toTodoItem(todoItemPfObject as! TodoItemDO))
                    }
                }
            }
            completion(todoItems, error)
        }
    }

    func getAllTodoItemsByCategoryId(completion : ([TodoItem], NSError?) -> Void) {
        var todoItems : [TodoItem] = []
        todoItemDao.getAllByForeignKey { (todoItemPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let todoItemPfObjects = todoItemPfObjects {
                    for todoItemPfObject in todoItemPfObjects {
                        todoItems.append(self.todoItemMapper.toTodoItem(todoItemPfObject as! TodoItemDO))
                    }
                }
            }
            completion(todoItems, error)
        }
    }    
}
