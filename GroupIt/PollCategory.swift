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
    var pollOptions : PollOption?
    
    init() {
        super.init(categoryType: .POLL)
    }
    
    init(pollCategoryDictionary : Dictionary<String, AnyObject>) {
        super.init(categoryDictionary: pollCategoryDictionary)
        pollOptions = PollOption(pollOptionDictionary: pollCategoryDictionary["pollOptions"] as! Dictionary)
    }
    
    override var description: String {
        get {
            return "\(super.description), \(self.pollOptions!)"
        }
    }
}


class PollOption {
    
    var pollOptionDescription : String?
    
    init(pollOptionDictionary : Dictionary<String, AnyObject>) {
        pollOptionDescription = pollOptionDictionary["pollOptionDescription"] as? String
    }
}