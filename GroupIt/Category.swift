//
//  Category.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class Category: CustomStringConvertible {
    /**
     * categoryId, categoryType enum, categoryOwner
     */
    
    var categoryId : String?
    var categoryType : CategoryType
    var categoryName : String?
    var categoryDescription : String?
    
    init(categoryType : CategoryType) {
        //assigning todo as default category.
        self.categoryType = categoryType
    }
    
    init(categoryDictionary : Dictionary<String, AnyObject?>) {
        self.categoryId = categoryDictionary["categoryId"] as? String
        self.categoryType = CategoryType.getCategoryType(categoryDictionary["categoryType"] as? String)
        self.categoryName = categoryDictionary["categoryName"] as? String
        self.categoryDescription = categoryDictionary["categoryDescription"] as? String
    }
    
    var description: String {
        return "\(categoryId), \(categoryName), \(categoryType)"
    }    
}

enum CategoryType : String {
    
    case TODO
    case POLL
    case IMAGES
    static let allValues = [TODO, POLL, IMAGES]
    
    static func getCategoryType(categoryTypeString : String?) -> CategoryType {
        if let categoryTypeString = categoryTypeString {
            if categoryTypeString == "TODO" {
                return .TODO
            } else if categoryTypeString == "POLL" {
                return .POLL
            } else if categoryTypeString == "IMAGES" {
                return .IMAGES
            }
        }
        return POLL
    }
}

func getAllCategoryTypes() -> [CategoryType]{
    return CategoryType.allValues
}