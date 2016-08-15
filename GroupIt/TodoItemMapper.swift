//
//  TodoItemMapper.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class TodoItemMapper: NSObject {

    func toPFObject(todoItem : TodoItem) -> PFObject {
        let todoItemPFObject = PFObject(className: Constants.TODO_ITEM_CLASSNAME)
        todoItemPFObject.objectId = todoItem.id
        todoItemPFObject["todoItemName"] = todoItem.todoItemName
        todoItemPFObject["completed"] = todoItem.isCompleted
        return todoItemPFObject
    }
    
    func toPFObjects(todoItems : [TodoItem]) -> [PFObject] {
        var todoItemPFObjects : [PFObject] = []
        for todoItem  in todoItems {
            todoItemPFObjects.append(toPFObject(todoItem))
        }
        return todoItemPFObjects
    }

    func toTodoItem(pfObject:PFObject) -> TodoItem {
        var todoItemDictionary : Dictionary<String, AnyObject> = [:]
        todoItemDictionary["id"] = pfObject.objectId
        todoItemDictionary["todoItemName"] = pfObject.objectForKey("todoItemName") as! String
        todoItemDictionary["completed"] = pfObject.objectForKey("completed") as! Bool
        return TodoItem(todoItemDictionary: todoItemDictionary)
    }
    
    func toTodoItems(pfObjects : [PFObject]?) -> [TodoItem] {
        var todoItems : [TodoItem] = []
        if let pfObjects = pfObjects {
            for pfObject in pfObjects {
                todoItems.append(toTodoItem(pfObject))
            }
        }
        return todoItems
    }

}
