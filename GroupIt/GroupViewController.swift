//
//  GroupViewController.swift
//  GroupIt
//
//  Created by Saumeel Gajera on 8/15/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let groupManager = TodoCategoryManager()
    let todoItemManager = TodoItemManager()
    let categoryDataUtil = TodoCategoryDataUtil()
//    var toDoCategories : [TodoCategory]?
    
    var group : Group?
    
    let id = "2VhIUxULKz"
    
    func makeNetworkCallToRefreshTheTableView(){
        groupManager.getAllTodoCategories({ (toDoCategories : [TodoCategory], error : NSError?) in
            self.group?.categories = toDoCategories
            self.tableView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        print(group?.groupName)
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        makeNetworkCallToRefreshTheTableView()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return toDoCategories?.count ?? 0
        return group?.categories?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCell
//        cell.category = self.toDoCategories![indexPath.row]
        cell.category = self.group?.categories![indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sender = tableView.cellForRowAtIndexPath(indexPath) as! CategoryCell
        performSegueWithIdentifier(Constants.READ_GROUP_TODO_CATEGORY_SEGUE, sender: sender)
    }
    
    @IBAction func onCreateButton(sender: UIButton){
        print("on create button")
        let category = categoryDataUtil.createTodoCategory()
        groupManager.upsertTodoCategory(category) { (created: Bool, error: NSError?) in
            if error == nil{
                print(created)
                self.makeNetworkCallToRefreshTheTableView()
            } else {
                print(error)
            }
        }
    }
    
    @IBAction func onGetButton(sender: UIButton){
        print("get by id")
        groupManager.getTodoCategoryById(id) { (todoCategory, error) in
            if error == nil {
                print(todoCategory)
            }else {
                print(error)
            }
        }
    }
    
    @IBAction func onGetAllButton(sender: UIButton){
        print("on get all button")
        makeNetworkCallToRefreshTheTableView()
    }
    
    @IBAction func onDeleteButton(sender: UIButton){
        print("on delete button")
        groupManager.deleteTodoCategoryById(id) { (deleted: Bool, error: NSError?) in
            if error == nil {
                print(deleted)
                self.makeNetworkCallToRefreshTheTableView()
            } else {
                print(error)
            }
        }
    }
    
    @IBAction func onDeleteAllButton(sender: UIButton){
        print("All Delete")
        groupManager.deleteAllCategories { (error: NSError?) in
            if error == nil {
                print ("deleted all")
                self.makeNetworkCallToRefreshTheTableView()
            }else {
                print(error)
            }
        }
    }
    
    @IBAction func onupdateButton(sender: UIButton){
        print("on update button ")
    }
    
    
    @IBAction func onAddCategoryButton(sender: AnyObject) {
        print("on add category button")
        let alertController = UIAlertController(title: "Add Category", message: "Choose Wisely", preferredStyle: .ActionSheet)

        // create a dismiss action
        let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        // create an OK action
        let toDoAction = UIAlertAction(title: "ToDo", style: .Destructive) { (action) in
            self.performSegueWithIdentifier(Constants.SETUP_GROUP_TODO_CATEGORY_SEGUE, sender: self)
        }
        alertController.addAction(toDoAction)

        let pollAction = UIAlertAction(title: "Poll", style: .Destructive) { (action) in
            //call poll setup
        }
        alertController.addAction(pollAction)
        
        let imagesAction = UIAlertAction(title: "Images", style: .Destructive) { (action) in
            //call images setup
        }
        alertController.addAction(imagesAction)
        presentViewController(alertController, animated: true) { 
            print("alert presented!")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.READ_GROUP_TODO_CATEGORY_SEGUE {
            print(sender)
            let todoDetailsVeiwController = segue.destinationViewController as! TodoDetailsViewController
            let categoryCell = sender as! CategoryCell
            let indexPath = tableView.indexPathForCell(categoryCell)
            let todoCategory = self.group?.categories![(indexPath?.row)!]
            todoItemManager.getAllTodoItemsByCategoryId((todoCategory?.id)!, completion: { (todoItems : [TodoItem], error : NSError?) in
                todoCategory!.todoItems = todoItems
                todoDetailsVeiwController.todoCategory = todoCategory
                todoDetailsVeiwController.todoItemsTableView.reloadData()
            })
        }
    }
}
