//
//  TodoCategoryMapper.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class TodoCategoryMapper: NSObject {

    private let todoItemMapper = TodoItemMapper()
    
    func toTodoCategory(pfObject : PFObject?) -> TodoCategory? {
        var todoCategoryDictionary : Dictionary<String, AnyObject> = [:]
        if let pfObject = pfObject {
            todoCategoryDictionary["id"] = pfObject.objectId
            todoCategoryDictionary["todoName"] = pfObject.objectForKey("todoName") as! String
            todoCategoryDictionary["todoDescription"] = pfObject.objectForKey("todoDescription") as! String
            var todoItems : [TodoItem] = []
            let todoItemsPFObjects : [PFObject] = pfObject.objectForKey("todoItems") as! [PFObject]
            for todoItemPFObject in todoItemsPFObjects {
                do {
                    try todoItemPFObject.fetchIfNeeded()
                    todoItems.append(todoItemMapper.toTodoItem(todoItemPFObject))
                } catch {
                    print("can't map to TodoItem for objectId \(todoItemPFObject.objectId)")
                }
            }
            todoCategoryDictionary["todoItems"] = todoItems
        }
        return TodoCategory(todoCategoryDictionary: todoCategoryDictionary)
    }
  
    
    func toTodoCategories(pfObjects : [PFObject]?) -> [TodoCategory] {
        var todoCategories : [TodoCategory] = []
        if let pfObjects = pfObjects {
            for pfObject in pfObjects {
                todoCategories.append(toTodoCategory(pfObject)!)
            }
        }
        return todoCategories
    }

    func toPFObject(todoCategory : TodoCategory) -> PFObject {
        let todoCategoryPFObject = PFObject(className: Constants.TODO_CATEGORY_CLASSNAME)
        todoCategoryPFObject.objectId = todoCategory.id
        todoCategoryPFObject["todoName"] = todoCategory.todoName
        todoCategoryPFObject["todoDescription"] = todoCategory.todoDescription
        todoCategoryPFObject["todoItems"] = todoItemMapper.toPFObjects(todoCategory.todoItems)
        return todoCategoryPFObject
    }

}
