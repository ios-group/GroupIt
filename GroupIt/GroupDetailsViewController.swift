//
//  GroupDetailsViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupDetailsViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tabBarView: GroupTabBarView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var categoriesImageView: UIImageView!
    
    @IBOutlet weak var usersImageView: UIImageView!
    
    var groupCategoriesViewController : GroupCategoriesViewController!
    var groupMembersViewController : GroupMembersViewController!
    
    var tabBarViewControllers : [UIViewController]!

    var group : Group?
    var isCategoriesTabSelected : Bool = true
    
    func onAddButton() {
        print("adding ...")
        if (isCategoriesTabSelected) {
            print("adding category ...")
            groupCategoriesViewController.onAddButton()
        } else {
            print("adding user ...")
            groupMembersViewController.onAddButton()
        }
    }
    
    func beautify() {
        tabBarView.backgroundColor = ColorTheme.NAV_BAR_COLOR
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        beautify()
        
        self.title = group?.groupName
//        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
//        self.navigationItem.rightBarButtonItem = addButton
        addNavBarButton()
        
        let groupCategoryStoryboard = UIStoryboard(name: Constants.GROUP_CATEGORY_STORYBOARD_NAME, bundle: nil)
        let groupMemberStoryboard = UIStoryboard(name: Constants.GROUP_MEMBER_STORYBOARD_NAME, bundle: nil)
        
        groupCategoriesViewController = groupCategoryStoryboard.instantiateViewControllerWithIdentifier(Constants.GROUP_CATEGORY_VIEW_CONTROLLER_ID) as? GroupCategoriesViewController
        groupMembersViewController = groupMemberStoryboard.instantiateViewControllerWithIdentifier(Constants.GROUP_MEMBER_VIEW_CONTROLLER_ID) as? GroupMembersViewController

        tabBarViewControllers = [groupCategoriesViewController, groupMembersViewController]
        // Do any additional setup after loading the view.
        onCategoriesBarItemTap(self)
        
        
        self.categoriesImageView.userInteractionEnabled = true
        let categoriesTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCategoriesBarItemTap))
        categoriesTapGestureRecognizer.delegate = self
        self.categoriesImageView.addGestureRecognizer(categoriesTapGestureRecognizer)

        self.usersImageView.userInteractionEnabled = true
        let usersTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onUsersBarItemTap))
        usersTapGestureRecognizer.delegate = self
        self.usersImageView.addGestureRecognizer(usersTapGestureRecognizer)

    }

    func addNavBarButton() {
        let addButton = UIButton()
        addButton.setImage(GroupImageUtil.getAddImage(), forState: .Normal)
        addButton.frame = CGRectMake(0, 0, 24, 24)
        addButton.addTarget(self, action: #selector(onAddButton), forControlEvents: .TouchUpInside)
        let addBarButton = UIBarButtonItem(customView: addButton)
        self.navigationItem.setRightBarButtonItem(addBarButton, animated: true)
    }

    func refresh() {
        print("refreshing ...")
        if (isCategoriesTabSelected) {
            print("refreshing category ...")
            groupCategoriesViewController.tableView.reloadData()
        } else {
            print("refreshing user ...")
            groupMembersViewController.groupMembersTableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCategoriesPanGestureTap(sender: UIPanGestureRecognizer) {
        print("categories gesture ...")
    }
    
    @IBAction func onCategoriesBarItemTap(sender: AnyObject) {
        isCategoriesTabSelected = true
        print("categories tab selected ...")
        addChildViewController(groupCategoriesViewController)
        
        groupCategoriesViewController.group = self.group
        groupCategoriesViewController.view.frame = contentView.frame
        contentView.addSubview(groupCategoriesViewController.view)
        groupCategoriesViewController.didMoveToParentViewController(self)
    }
    
    
    @IBAction func onUsersBarItemTap(sender: AnyObject) {
        isCategoriesTabSelected = false
        print("users tab selected ...")
        addChildViewController(groupMembersViewController)
        
        groupMembersViewController.group = self.group
        groupMembersViewController.view.frame = contentView.frame
        contentView.addSubview(groupMembersViewController.view)
        groupMembersViewController.didMoveToParentViewController(self)
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
