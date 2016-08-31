//
//  GroupsViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let groupManager = GroupManager()
    let todoCategoryManager = TodoCategoryManager()
    let groupMemberManager = GroupMemberManager()
    let groupDataUtil = GroupDataUtil()
    var groups: [Group] = []
    @IBOutlet weak var tableView: UITableView!
    
    func onAddButton() {
        print("adding a new group ... ")
        let group = Group()
        performSegueWithIdentifier(Constants.CREATE_GROUP_SEGUE, sender: group)
    }

    func beautify() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg-image-2.png"))
        tableView.separatorStyle = .None
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside GroupsViewController")

        beautify()
        
        //instantiate tableview details
        tableView.delegate = self
        tableView.dataSource = self
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem = addButton

        //get all the groups for
//        getAllGroups()
        let userId = (User.currentUser?.userId)!
        getGroupsByUser(userId)
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        User.currentUser = nil
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let groupCell = tableView.dequeueReusableCellWithIdentifier("GroupsCell", forIndexPath: indexPath) as! GroupsCell
        groupCell.group = groups[indexPath.row]
        groupCell.delegate = self
        groupCell.backgroundColor = UIColor.clearColor()
        return groupCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sender = tableView.cellForRowAtIndexPath(indexPath) as! GroupsCell
        performSegueWithIdentifier(Constants.GROUP_DETAILS_SEGUE, sender: sender)
//        performSegueWithIdentifier(Constants.READ_GROUPS_GROUP_SEGUE, sender: sender)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("deleting group ...")
            let groupToDelete = self.groups[indexPath.row]
            self.groups.removeAtIndex(indexPath.row)
            groupMemberManager.deleteRelationsByGroupId(groupToDelete.groupId!)
            groupManager.deleteGroupById((groupToDelete.groupId)!, completion: { (deleted : Bool, error : NSError?) in
                if error == nil {
                    print(deleted)
                } else {
                    print(error)
                }
            })
            self.tableView.reloadData()
        }
    }

    //================== GROUPS Library Operations =====================
    
    private func getAllGroups() {
        print("Inside getAllGroups()")
        
        groupManager.getAllGroups({ (groups: [Group], error: NSError?) in
            if error == nil {
                print("All Group List Fetched")
                self.groups = groups
                for group in groups {
                    print(group)
                }
                self.tableView.reloadData()
            } else {
                print(error)
            }
        })
    }
    
    private func getGroupsByUser(userId : String) {
        groupMemberManager.getAllGroupsByUserId(userId) { (groups : [Group], error : NSError?) in
            if error == nil {
                self.groups = groups
                self.tableView.reloadData()
            } else {
                print(error)
            }
        }
    }
    
    private func deleteAllGroups() {
        print("Inside deleteAllGroups()")
        
        groupManager.deleteAllGroups { (error: NSError?) in
            if error == nil {
                print("ALl groups deleted")
                self.groups = []
                self.tableView.reloadData()
            }else{
                print(error)
            }
        }
    }
    
    private func deleteGroupById(groupId : String) {
        print("Inside deleteGroupById()")
        groupManager.deleteGroupById(groupId) { (deleted : Bool, error : NSError?) in
            if error == nil {
                print(deleted)
            } else {
                print(error)
            }
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        print("prepare for segue")
        if segue.identifier == Constants.CREATE_GROUP_SEGUE {
            let groupCreateViewController = segue.destinationViewController as! GroupCreateViewController
            groupCreateViewController.delegate = self
            let group = sender as! Group
            groupCreateViewController.group = group
        }
        if segue.identifier == Constants.READ_GROUPS_GROUP_SEGUE {
            let groupViewController = segue.destinationViewController as! GroupCategoriesViewController
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let group = groups[(indexPath?.row)!]
            groupViewController.group = group
            todoCategoryManager.getAllTodoCategoriesByGroupId(group.groupId!, completion: { (todoCategories : [Category], error : NSError?) in
                group.categories = todoCategories
                groupViewController.group = group
                groupViewController.tableView.reloadData()
            })
        }
        if segue.identifier == Constants.GROUP_DETAILS_SEGUE {
            print("preparing group details segue...")
            let groupDetailsViewController = segue.destinationViewController as! GroupDetailsViewController
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let group = groups[(indexPath?.row)!]
            groupDetailsViewController.group = group
            todoCategoryManager.getAllTodoCategoriesByGroupId(group.groupId!, completion: { (todoCategories : [Category], error : NSError?) in
                group.categories = todoCategories
                groupDetailsViewController.group = group
                groupDetailsViewController.refresh()
            })
            groupMemberManager.getAllMembersByGroupId(group.groupId!, completion: { (groupMembers : [User], error : NSError?) in
                group.groupMembers = groupMembers
                groupDetailsViewController.group = group
                groupDetailsViewController.refresh()
            })
        }
    }
}

extension GroupsViewController : GroupCreateDelegate {
    func onSave(group: Group) {
        print("saving group ..")
        if group.groupId != nil {
            findAndRemove(group)
        }
//        groupManager.upsertGroup(group) { (saved : Bool, group: Group, error : NSError?) in
//            if error == nil {
//                print(saved)
//                self.groups.append(group)
//                self.tableView.reloadData()
//            } else {
//                print(error)
//            }
//        }
        let currentUser = User.currentUser
        groupMemberManager.createRelation(group, user: currentUser!) { (created : Bool, group : Group, user: User, error : NSError?) in
            if error == nil {
                self.groups.append(group)
                self.tableView.reloadData()
                print("\(currentUser) added to \(group.groupName)")
            } else {
                print(error)
            }
        }
    }
    
    func findAndRemove(group : Group) {
        let groupIndex = findIndex(group)
        if let groupIndex = groupIndex {
            self.groups.removeAtIndex(groupIndex)
        }
    }
    
    func findIndex(group : Group) -> Int? {
        for i in 0 ..< groups.count {
            let existingGroup = groups[i]
            if existingGroup.groupId == group.groupId {
                return i
            }
        }
        return nil
    }
}

extension GroupsViewController : GroupCellDelegate {
    func onLongPress(group: Group) {
        performSegueWithIdentifier(Constants.CREATE_GROUP_SEGUE, sender: group)
    }
}
