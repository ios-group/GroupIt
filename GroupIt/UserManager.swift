//
//  UserManager.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/23/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class UserManager: NSObject {
   
    let userDao = ParseDAO(className: Constants.USER_CLASSNAME)
    let userMapper = UserMapper()
    
    func upsertUser(user : User, completion : (Bool, NSError?) -> ()) -> Void {
        
        let userDO = UserDO()
        userDO.objectId = user.userId
        userDO.username = user.username
        userDO.email = user.email
        userDO.password = user.password
        userDao.createUser(userDO) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
}
