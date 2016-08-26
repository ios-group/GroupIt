//
//  UserMapper.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/23/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class UserMapper: NSObject {
    
    func toUserDO(user : User) -> UserDO {
        print("inside toUserDO")
        let userDO = UserDO()
        
        userDO.objectId = user.userId
        userDO.username = user.username
        userDO.email = user.email
        userDO.password = user.password
        return userDO
    }

    func toUser(userDO : UserDO) -> User {
        var userDictionary = Dictionary<String, AnyObject>()
        userDictionary["userId"] = userDO.objectId
        userDictionary["username"] = userDO.username
        userDictionary["email"] = userDO.email
        userDictionary["password"] = userDO.password
        
        let user = User(userDictionary: userDictionary)
        return user
    }
}
