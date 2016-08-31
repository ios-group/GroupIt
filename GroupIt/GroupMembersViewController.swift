//
//  GroupMembersViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/28/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupMembersViewController: UIViewController {

    
    @IBOutlet weak var groupMembersTableView: UITableView!
    
    var group : Group?
    
    let userManager = UserManager()
    
    func onAddButton() {
        print("adding a new member ... ")
        self.performSegueWithIdentifier(Constants.GROUP_MEMBERS_ADD_SEGUE, sender: group)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupMembersTableView.dataSource = self
        groupMembersTableView.delegate = self
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if segueIdentifier == Constants.GROUP_MEMBERS_ADD_SEGUE {
            print("preparing for group members add segue ...")
            let groupMembersAddViewController = segue.destinationViewController as! GroupMembersAddViewController
            groupMembersAddViewController.group = sender as? Group
        }
    }
    
}

extension GroupMembersViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return group?.groupMembers?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let groupMemberCell = tableView.dequeueReusableCellWithIdentifier(Constants.GROUP_MEMBER_CELL_ID) as! GroupMemberCell
        let groupMember = group?.groupMembers![indexPath.row]
        populateCell(groupMemberCell, groupMember: groupMember!)
        return groupMemberCell
    }
    
    func populateCell(groupMemberCell : GroupMemberCell, groupMember : User) {
        groupMemberCell.groupMember = groupMember
        groupMemberCell.groupMemberNameLabel.text = groupMember.username
    }
}