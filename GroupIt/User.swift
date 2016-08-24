//
//  User.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class User: NSObject {
    
    /*
     * userId, name, email, phone, password
     */
    
    var userId : String?
    var username : String?
    var email : String?
    var password : String?
    var groups : [Group]?
   
    override init() {
        //no-op
    }
    
    init(groupDictionary : Dictionary<String, AnyObject?>) {
        
        userId = groupDictionary["userId"] as? String
        username = groupDictionary["username"] as? String
        email = groupDictionary["email"] as? String
        password = groupDictionary["password"] as? String
       // groups = groupDictionary["groups"] as? [Group] ?? []
    }
}
