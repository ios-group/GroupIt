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
    var dictionary : Dictionary<String, AnyObject>?
    
    //Notification for Logout - Observer 
    static let userDidLogoutNotification = "UserDidLogout"

    override init() {
        //no-op
    }
    
    init(userDictionary : Dictionary<String, AnyObject>) {
        
        //Setting value to itself as we need it for current user mapping in get/set
        self.dictionary = userDictionary
        userId = userDictionary["userId"] as? String
        username = userDictionary["username"] as? String
        email = userDictionary["email"] as? String
        password = userDictionary["password"] as? String
       // groups = userDictionary["groups"] as? [Group] ?? []
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        
        get {
            print("Inside User current get")
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if _currentUser == nil {
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! Dictionary<String, AnyObject>
                    
                    _currentUser = User(userDictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            print("Inside User current set")
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user{
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
}
