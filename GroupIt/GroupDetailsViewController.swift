//
//  GroupDetailsViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupDetailsViewController: UIViewController {

    
    @IBOutlet weak var contentView: UIView!
    
    var groupCategoriesViewController : GroupCategoriesViewController!
    var groupMembersViewController : GroupMembersViewController!
    
    var tabBarViewControllers : [UIViewController]!

    var group : Group?
    
    func onAddButton() {
        print("adding ...")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = group?.groupName
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem = addButton

        
        let groupCategoryStoryboard = UIStoryboard(name: Constants.GROUP_CATEGORY_STORYBOARD_NAME, bundle: nil)
        let groupMemberStoryboard = UIStoryboard(name: Constants.GROUP_MEMBER_STORYBOARD_NAME, bundle: nil)
        
        groupCategoriesViewController = groupCategoryStoryboard.instantiateViewControllerWithIdentifier(Constants.GROUP_CATEGORY_VIEW_CONTROLLER_ID) as? GroupCategoriesViewController
        groupMembersViewController = groupMemberStoryboard.instantiateViewControllerWithIdentifier(Constants.GROUP_MEMBER_VIEW_CONTROLLER_ID) as? GroupMembersViewController

        tabBarViewControllers = [groupCategoriesViewController, groupMembersViewController]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCategoriesBarItemTap(sender: AnyObject) {
        print("categories tab selected ...")
        addChildViewController(groupCategoriesViewController)
        
        groupCategoriesViewController.group = self.group
        groupCategoriesViewController.view.frame = contentView.frame
        contentView.addSubview(groupCategoriesViewController.view)
        groupCategoriesViewController.didMoveToParentViewController(self)
    }
    
    
    @IBAction func onUsersBarItemTap(sender: AnyObject) {
        print("users tab selected ...")
        addChildViewController(groupMembersViewController)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
