//
//  PollCategory.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class PollCategory: Category {

    /* pollName, pollDescription, <Option>  */
    var id : String?
    var pollName : String?
    var pollDescription : String?
    var pollOptions : PollOption?
    
    init() {
        //no-op
    }
    
    init(pollCategoryDictionary : Dictionary<String, AnyObject>) {
        id = pollCategoryDictionary["id"] as? String
        pollName = pollCategoryDictionary["pollName"] as? String
        pollDescription = pollCategoryDictionary["pollDescription"] as? String
        pollOptions = PollOption(pollOptionDictionary: pollCategoryDictionary["pollOptions"] as! Dictionary)
    }
    
    var description: String {
        get {
            return self.pollName!
        }
    }
    
    func getCategoryType() -> CategoryType {
        return CategoryType.POLL
    }
    
    func getID() -> String? {
        return id
    }
    
    func getName() -> String? {
        return pollName
    }
}


class PollOption {
    
    var pollOptionDescription : String?
    
    init(pollOptionDictionary : Dictionary<String, AnyObject>) {
        pollOptionDescription = pollOptionDictionary["pollOptionDescription"] as? String
    }
}