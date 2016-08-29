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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupMembersTableView.dataSource = self
        groupMembersTableView.delegate = self
        
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