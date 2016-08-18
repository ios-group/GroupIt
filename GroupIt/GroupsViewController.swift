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
    let groupDataUtil = GroupDataUtil()
    var groups: [Group] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        print("Inside GroupsViewController")
        super.viewDidLoad()
        
        //instantiate tableview details
        tableView.delegate = self
        tableView.dataSource = self

        //get all the groups for
        getAllGroups()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupsCell", forIndexPath: indexPath) as! GroupsCell
        cell.groupDetails = groups[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let sender = tableView.cellForRowAtIndexPath(indexPath) as! GroupsCell
        performSegueWithIdentifier(Constants.READ_GROUPS_GROUP_SEGUE, sender: sender)
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

    private func createGroup() {
        print("Inside createGroup()")
        let group = groupDataUtil.createGroup()
        
        groupManager.createGroup(group) { (created: Bool, error: NSError?) in
            if error == nil {
                print("Group Created")
            } else {
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
        if segue.identifier == Constants.READ_GROUPS_GROUP_SEGUE {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let groupDetails = groups[(indexPath?.row)!]
            
            let groupViewController = segue.destinationViewController as! GroupViewController
            groupViewController.group = groupDetails
        }
    }
}
