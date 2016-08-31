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
    
    func getAllUsers(completion : ([User]?, NSError?) -> ()) {
        var users : [User] = []
        userDao.getAll { (userPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let userPfObjects = userPfObjects {
                    for userPfObject in userPfObjects {
                        users.append(self.userMapper.toUser(userPfObject as! UserDO))
                    }
                }
            }
            completion(users, error)
        }
    }
    
    
    func upsertUser(user : User, completion : (Bool, NSError?) -> ()) -> Void {
        
        let userDO = UserDO()
        userDO.objectId = user.userId
        userDO.username = user.username
        userDO.email = user.email
        userDO.password = user.password
        userDao.signUpUser(userDO) { (created : Bool, error : NSError?) in
            completion(created, error)
        }
    }
    
    func loginUser(username: String, password: String, completion: (User?, NSError?) -> Void) {
        
        var user1 = User()
        userDao.loginUser(username, password: password) { (user : PFUser?, error: NSError?) in
            if error == nil {
                if let user = user {
                    user1 = self.userMapper.toUser(user as! UserDO)
                }
            }
            completion(user1, error)
        }
    }
}
