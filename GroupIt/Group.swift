//
//  Group.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class Group: NSObject {

    /**
     * groupId, groupName, groupDescription, <user>, <category>
     */
    var groupId : String?
    var groupName : String?
    var groupDescription : String?
    var categories : [Category]?
    var groupOwner : User?
    
    override init() {
        //no-op
    }
    
    init(groupDictionary : Dictionary<String, AnyObject?>) {
        groupId = groupDictionary["groupId"] as? String
        groupName = groupDictionary["groupName"] as? String
        groupDescription = groupDictionary["groupDescription"] as? String
        categories = groupDictionary["categories"] as? [Category] ?? []
        groupOwner = groupDictionary["groupOwner"] as? User!
    }
}
