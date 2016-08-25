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

    func toTodoCategoryDO(groupDO : GroupDO, todoCategory : Category) -> CategoryDO {
        let todoCategoryDO = CategoryDO()
        todoCategoryDO.objectId = todoCategory.categoryId
        todoCategoryDO["categoryName"] = todoCategory.categoryName
        todoCategoryDO["categoryType"] = todoCategory.categoryType.rawValue
//        todoCategoryDO["todoDescription"] = todoCategory.todoDescription
        todoCategoryDO["group"] = groupDO
        return todoCategoryDO
    }
    
    func toTodoCategory(todoCategoryDO : CategoryDO) -> Category {
        var todoCategoryDictionary = Dictionary<String, AnyObject?>()
        print("...\(todoCategoryDO["categoryType"])")
        todoCategoryDictionary["categoryId"] = todoCategoryDO.objectId
//        todoCategoryDictionary["categoryType"] = todoCategoryDO.objectId
        todoCategoryDictionary["categoryName"] = todoCategoryDO.categoryName
        todoCategoryDictionary["categoryType"] = todoCategoryDO.categoryType
//        todoCategoryDictionary["categoryDescription"] = todoCategoryDO.categoryDescription
        todoCategoryDictionary["group"] = todoCategoryDO.group
        let todoCategory = Category(categoryDictionary: todoCategoryDictionary)
        return todoCategory
    }
    
    func toDictionary(category : Category) -> Dictionary<String, AnyObject?> {
        var categoryDictionary = Dictionary<String, AnyObject?>()
        categoryDictionary["categoryId"] = category.categoryId
        categoryDictionary["categoryType"] = category.categoryType.rawValue
        categoryDictionary["categoryName"] = category.categoryName
        categoryDictionary["categoryDescription"] = category.categoryDescription
        return categoryDictionary
    }
}
