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
    
    func onAddButton() {
        print("adding a new category ... ")
        
        print("on add category button")
        let alertController = UIAlertController(title: "Add Category", message: "Choose Wisely", preferredStyle: .ActionSheet)
        
        // create a dismiss action
        let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        // create an OK action
        let toDoAction = UIAlertAction(title: "ToDo", style: .Destructive) { (action) in
            let category = TodoCategory()
            self.performSegueWithIdentifier(Constants.CREATE_CATEGORY_SEQUE, sender: category)
//            self.performSegueWithIdentifier(Constants.SETUP_GROUP_TODO_CATEGORY_SEGUE, sender: self)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.title = group?.groupName
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem = addButton
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
        cell.delegate = self
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let sender = tableView.cellForRowAtIndexPath(indexPath) as! CategoryCell
        performSegueWithIdentifier(Constants.READ_GROUP_TODO_CATEGORY_SEGUE, sender: sender)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("deleting ...")
            let categoryToDelete = self.group?.categories![indexPath.row]
            self.group?.categories?.removeAtIndex(indexPath.row)
            groupManager.deleteTodoCategoryById((categoryToDelete?.getID())!, completion: { (deleted : Bool, error : NSError?) in
                if error == nil {
                    print(deleted)
                } else {
                    print(error)
                }
            })
            self.tableView.reloadData()
        }
    }
    
//    @IBAction func onCreateButton(sender: UIButton){
//        print("on create button")
//        let category = categoryDataUtil.createTodoCategory()
//        groupManager.upsertTodoCategory(category) { (created: Bool, error: NSError?) in
//            if error == nil{
//                print(created)
//                self.makeNetworkCallToRefreshTheTableView()
//            } else {
//                print(error)
//            }
//        }
//    }
    
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
        let segueIdentifier = segue.identifier
        
        if segueIdentifier == Constants.CREATE_CATEGORY_SEQUE {
            let categoryCreateViewController = segue.destinationViewController as! CategoryCreateViewController
            let category = sender as! Category
            categoryCreateViewController.category = category
            categoryCreateViewController.delegate = self
        }
        if segue.identifier == Constants.READ_GROUP_TODO_CATEGORY_SEGUE {
            print(sender)
            let todoDetailsVeiwController = segue.destinationViewController as! TodoDetailsViewController
            let categoryCell = sender as! CategoryCell
            let indexPath = tableView.indexPathForCell(categoryCell)
            let todoCategory = self.group?.categories![(indexPath?.row)!]
            todoDetailsVeiwController.todoCategory = todoCategory
            todoItemManager.getAllTodoItemsByCategoryId((todoCategory?.id)!, completion: { (todoItems : [TodoItem], error : NSError?) in
                todoCategory!.todoItems = todoItems
                todoDetailsVeiwController.todoCategory = todoCategory
                todoDetailsVeiwController.todoItemsTableView.reloadData()
            })
        }
    }
}

extension GroupViewController : CategoryCreateDelegate {
    func onSave(category : Category) {
        if (category.getID() != nil) {
            findAndRemove(category)
        }
        self.group?.categories?.append(category as! TodoCategory)
        self.tableView.reloadData()
        let categoryType = category.getCategoryType()
        switch categoryType {
        case .TODO:
            groupManager.upsertTodoCategory((group?.groupId)!, todoCategory: category as! TodoCategory, completion: { (upserted : Bool, error : NSError?) in
                if error == nil {
                    print(upserted)
                } else {
                    print(error)
                }
            })
        default:
            print("default category...")
        }
    }
    
    func findAndRemove(category : Category) {
        let categoryIndex = findIndex(category)
        if let categoryIndex = categoryIndex {
            self.group?.categories?.removeAtIndex(categoryIndex)
        }
    }
    
    func findIndex(category: Category) -> Int? {
        let categories = self.group?.categories
        for i in 0 ..< categories!.count  {
            let existingCategory = categories![i]
            if existingCategory.id == category.getID() {
                return i
            }
        }
        return nil
    }

}

extension GroupViewController : CategoryCellDelegate {
    func onLongPress(category : Category) {
        performSegueWithIdentifier(Constants.CREATE_CATEGORY_SEQUE, sender: category as! TodoCategory)
    }
}


