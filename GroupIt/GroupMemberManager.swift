//
//  GroupMemberManager.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/29/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class GroupMemberManager: NSObject {
    let groupUserRelationDao = ParseDAO(className: Constants.GROUP_USER_RELATION_CLASSNAME)
    
    let userManager = UserManager()
    let userMapper = UserMapper()
    let groupMapper = GroupMapper()
    
    func getAllMembersByGroupId(groupId : String, completion : ([User], NSError?) -> Void) {
        var groupMembers : [User] = []
        let parseContext = ParseContext(className: Constants.GROUP_USER_RELATION_CLASSNAME)
        parseContext.className = Constants.GROUP_USER_RELATION_CLASSNAME
        parseContext.predicateFormat = "group IN %@"
        parseContext.innerClassName = Constants.GROUP_CLASSNAME
        parseContext.innerPredicateFormat = "objectId = '\(groupId)'"
        parseContext.includeKeyParams = ["user"]
        groupUserRelationDao.getAllByForeignKey(parseContext) { (groupMemberPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let groupMemberPfObjects = groupMemberPfObjects {
                    for groupMemberPfObject in groupMemberPfObjects {
                        let groupUserRelationDO = groupMemberPfObject as! GroupUserRelationDO
                        groupMembers.append(self.userMapper.toUser(groupUserRelationDO.user!))
                    }
                }
            }
            completion(groupMembers, error)
        }
    }


    func getAllGroupsByUserId(userId : String, completion : ([Group], NSError?) -> Void) {
        var groups : [Group] = []
        let parseContext = ParseContext(className: Constants.GROUP_USER_RELATION_CLASSNAME)
        parseContext.className = Constants.GROUP_USER_RELATION_CLASSNAME
        parseContext.predicateFormat = "user IN %@"
        parseContext.includeKeyParams = ["group", "group.groupOwner"]
        
        parseContext.innerClassName = Constants.USER_CLASSNAME
        parseContext.innerPredicateFormat = "objectId = '\(userId)'"
        
        groupUserRelationDao.getAllByForeignKey(parseContext) { (groupMemberPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let groupMemberPfObjects = groupMemberPfObjects {
                    for groupMemberPfObject in groupMemberPfObjects {
                        let groupUserRelationDO = groupMemberPfObject as! GroupUserRelationDO
                        if let group = groupUserRelationDO.group {
                            groups.append(self.groupMapper.toGroup(group))
                        }
                    }
                }
            }
            completion(groups, error)
        }
    }

    func createRelation(group: Group, user : User, completion : (Bool, Group, User, NSError?) -> Void) {
        let groupUserRelationDO = GroupUserRelationDO()
        groupUserRelationDO.group = groupMapper.toGroupDO(group)
        groupUserRelationDO.user = userMapper.toUserDO(user)
        groupUserRelationDao.upsert(groupUserRelationDO) { (created : Bool, pfObject : PFObject?, error:
            NSError?) in
            let groupUserRelationDO = pfObject as! GroupUserRelationDO
            let group = self.groupMapper.toGroup(groupUserRelationDO.group!)
            let user = self.userMapper.toUser(groupUserRelationDO.user!)
            completion(created, group, user, error)
        }
    }
    
    func deleteRelationsByGroupId(groupId : String) {
        let parseContext = ParseContext(className: Constants.GROUP_USER_RELATION_CLASSNAME)
        parseContext.className = Constants.GROUP_USER_RELATION_CLASSNAME
        parseContext.predicateFormat = "group IN %@"
        parseContext.innerClassName = Constants.GROUP_CLASSNAME
        parseContext.innerPredicateFormat = "objectId = '\(groupId)'"
        parseContext.includeKeyParams = ["user"]
        groupUserRelationDao.getAllByForeignKey(parseContext) { (groupMemberPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let groupMemberPfObjects = groupMemberPfObjects {
                    for groupMemberPfObject in groupMemberPfObjects {
                        let groupUserRelationDO = groupMemberPfObject as! GroupUserRelationDO
                        self.groupUserRelationDao.deleteById(groupUserRelationDO.objectId!, completion: { (deleted: Bool, error : NSError?) in
                            if error == nil {
                                print(deleted)
                            } else {
                                print(error)
                            }
                        })
                    }
                }
            }
        }

    }
}
