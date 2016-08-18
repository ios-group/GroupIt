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

    func toTodoCategoryDO(todoCategory : TodoCategory) -> TodoCategoryDO {
        let todoCategoryDO = TodoCategoryDO()
        todoCategoryDO.objectId = todoCategory.id
        todoCategoryDO.todoName = todoCategory.todoName
        todoCategoryDO.todoDescription = todoCategory.todoDescription
        return todoCategoryDO
    }
    
    func toTodoCategory(todoCategoryDO : TodoCategoryDO) -> TodoCategory {
        var todoCategoryDictionary = Dictionary<String, AnyObject?>()
        todoCategoryDictionary["todoName"] = todoCategoryDO.todoName
        todoCategoryDictionary["todoDescription"] = todoCategoryDO.todoDescription
//        todoItemDictionary["group"] = todoItemDO.group
        let todoCategory = TodoCategory(todoCategoryDictionary: todoCategoryDictionary)
        return todoCategory
    }
}
