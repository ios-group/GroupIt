//
//  TodoCategory.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Swift

class TodoCategory: Category {
    
    /* todoName, todoDescription, <todoItem>  */
    var id : String?
    var todoName : String?
    var todoDescription : String?
    var todoItems : [TodoItem]! = []
    
    init(todoCategoryDictionary : Dictionary<String, AnyObject?>) {
        id = todoCategoryDictionary["id"] as? String
        todoName = todoCategoryDictionary["todoName"] as? String
        todoDescription = todoCategoryDictionary["todoDescription"] as? String
        todoItems = todoCategoryDictionary["todoItems"] as? [TodoItem] ?? []
    }
    
    func getID() -> String? {
        return id
    }
    
    func getCategoryType() -> CategoryType {
        return CategoryType.TODO
    }
    
    func getName() -> String? {
        return todoName
    }
    
    func addTodoItem(todoItem : TodoItem) {
        todoItems.append(todoItem)
    }

    func getTodoItemIndexById(id : String) -> Int {
        var count : Int = 0
        for todoItem in todoItems {
            if todoItem.id == id {
                return count
            }
            count += 1
        }
        return -1
    }

    func getTodoItemById(id : String) -> TodoItem? {
        for todoItem in todoItems {
            if todoItem.id == id {
                return todoItem
            }
        }
        return nil
    }

    
    //TODO optimize
    func deleteTodoItem(id : String) {
        let index = getTodoItemIndexById(id)
        todoItems.removeAtIndex(index)
    }

    
    var description: String {
        get {
            return "\(self.id), \(self.todoName!), \(self.todoDescription!), \(self.todoItems)"
        }
    }
}

class TodoItem : CustomStringConvertible {
    /* todoItemName, isCompleted */
    var id : String?
    var todoItemName : String?
    var completed : Bool
    
    init(todoItemDictionary : Dictionary<String, AnyObject?>) {
        id = todoItemDictionary["id"] as? String
        todoItemName = todoItemDictionary["todoItemName"] as? String
        completed = todoItemDictionary["completed"] as? Bool ?? false
    }
    
    var description: String {
        get {
            return "\(self.todoItemName!), \(self.completed)"
        }
    }
}
