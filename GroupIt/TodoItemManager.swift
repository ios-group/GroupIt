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

    let todoItemDao = ParseDAO(className: Constants.TODO_ITEM_CLASSNAME)
    let todoItemMapper = TodoItemMapper()
    
    
    func createTodoItem(todoItem : TodoItem, completion : (Bool, NSError?) -> ()) -> Void {
        let pfObject = todoItemMapper.toPFObject(todoItem)
        todoItemDao.create(pfObject) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
    
    func updatetodoItem(id : String, todoItem : TodoItem, completion : (Bool, NSError?) -> Void) {
        let pfObjectNew = todoItemMapper.toPFObject(todoItem)
        todoItemDao.updateById(id, pfObjectNew: pfObjectNew) { (updated : Bool, error : NSError?) in
            completion(updated, error)
        }
    }
    
    func getAllTodoItems(completion : ([TodoItem], NSError?) -> Void) {
        todoItemDao.getAll { (pfObjects : [PFObject]?, error : NSError?) in
            completion(self.todoItemMapper.toTodoItems(pfObjects), error)
        }
    }
    
    func gettodoItemById(id : String, completion : (todoItem : TodoItem?, error : NSError?) -> Void) {
        todoItemDao.getById(id) { (pfObject: PFObject?, error : NSError?) in
            completion(todoItem: self.todoItemMapper.toTodoItem(pfObject!), error: error)
        }
    }
    
    func deleteTodoItemById(id : String, completion : (Bool, NSError?) -> Void)  {
        todoItemDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }
}
