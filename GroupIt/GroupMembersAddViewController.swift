//
//  GroupMemberCreateViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/29/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupMembersAddViewController: UIViewController {

    
    @IBOutlet weak var groupMembersToAddTableView: UITableView!
    
    let userManager = UserManager()
    let groupMemberManager = GroupMemberManager()
    
    var group : Group?
    var users : [User]?
    var usersToAdd : [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupMembersToAddTableView.dataSource = self
        groupMembersToAddTableView.delegate = self

        fetchAllUsers()
    }
    
    func fetchAllUsers() {
        userManager.getAllUsers { (users : [User]?, error : NSError?) in
            if error == nil {
                self.users = users
                self.groupMembersToAddTableView.reloadData()
            } else {
                print(error)
            }
        }
    }
}

extension GroupMembersAddViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let groupMemberAddCell = tableView.dequeueReusableCellWithIdentifier(Constants.GROUP_MEMBER_ADD_CELL_ID) as! GroupMemberAddCell
        let user = users![indexPath.row]
        populateCell(groupMemberAddCell, groupMember: user)
        groupMemberAddCell.delegate = self
        return groupMemberAddCell
    }
    
    func populateCell(groupMemberAddCell : GroupMemberAddCell, groupMember : User) {
        groupMemberAddCell.user = groupMember
        groupMemberAddCell.userNameLabel.text = groupMember.username
    }
}

extension GroupMembersAddViewController : GroupMemberAddCellDelegeate {
    func onAddUser(user: User) {
        self.usersToAdd?.append(user)
        print("adding user ... \(user)")
        self.groupMemberManager.createRelation(group!, user: user) { (created : Bool, group: Group, user: User, error : NSError?) in
            if error == nil {
                print("created relation ... \(self.group!.groupName) --> \(user.username)")
            } else {
                print(error)
            }
        }
    }
}


