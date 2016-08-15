//
//  ParseDAO.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class ParseDAO: NSObject {

    var className : String!
    
    init(className : String) {
        self.className = className
    }
    
    func create(pfObject :  PFObject, completion : (Bool, NSError?) -> Void) {
        pfObject.saveInBackgroundWithBlock { (created: Bool, error: NSError?) -> Void in
            completion(created, error)
        }
    }
    
    func updateById(id :String, pfObjectNew : PFObject, completion : (Bool, NSError?) -> Void) {
        getById(id) { (pfObject : PFObject?, error : NSError?) in
            if let pfObject = pfObject {
                pfObjectNew.objectId = pfObject.objectId
                pfObjectNew.saveInBackgroundWithBlock({ (updated :Bool, error : NSError?) in
                    completion(updated, error)
                })
            }
        }
    }
    
    func getAll(completion : ([PFObject]?, NSError?) -> Void) {
        let pfQuery = PFQuery(className: className)
        pfQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            completion(objects, error)
        }
    }
    
    func getById(id: String, completion : (PFObject?, NSError?) -> ()) {
        let pfQuery = PFQuery(className: className)
        pfQuery.includeKey("result.todoItems")
        pfQuery.getObjectInBackgroundWithId(id) { (pfObject : PFObject?, error : NSError?) in
            completion(pfObject, error)
        }
    }
    
    func deleteById(id : String, completion : (Bool, NSError?) -> ()) {
        getById(id) { (pfObject : PFObject?, error : NSError?) in
            if let pfObject = pfObject {
                pfObject.deleteInBackgroundWithBlock({ (deleted : Bool, error :NSError?) in
                    completion(deleted, error)
                })
            }
        }
    }

}
