//
//  TodoCategoryDataUtil.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class TodoCategoryDataUtil: NSObject {
    
    func createTodoItem(todoItemName : String) -> TodoItem {
        var todoItemDictionary : Dictionary<String, AnyObject> = [:]
        todoItemDictionary["todoItemName"] = todoItemName
        todoItemDictionary["completed"] = true
        return TodoItem(todoItemDictionary: todoItemDictionary)
    }
    
    func createTodoItems() -> [TodoItem] {
        let todoItemNames = ["todo-item-1", "todo-item-2", "todo-item-3"]
        var todoItems :[TodoItem] = []
        for todoItemName  in todoItemNames {
            todoItems.append(createTodoItem(todoItemName))
        }
        return todoItems
    }
    
    func createTodoCategory() -> TodoCategory {
        return createTodoCategory("todo-category-1")
    }
    
    func createTodoCategory(todoName : String) -> TodoCategory {
        var todoCategoryDictionary : Dictionary<String, AnyObject> = [:]
        todoCategoryDictionary["todoName"] = todoName
        todoCategoryDictionary["todoDescription"] = "todo-category-description"
        todoCategoryDictionary["todoItems"] = createTodoItems()
        return TodoCategory(todoCategoryDictionary: todoCategoryDictionary)
    }
}
