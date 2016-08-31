//
//  TodoDetailsViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class TodoDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let todoCategoryManager = TodoCategoryManager()
    let todoItemManager = TodoItemManager()
    let todoCategoryDataUtil = TodoCategoryDataUtil()
    
    var todoCategory : TodoCategory?
    
    @IBOutlet weak var todoItemsTableView: UITableView!
    
    func onAddButton() {
        print("adding a new todo item ... ")
        performSegueWithIdentifier(Constants.CREATE_TODO_ITEM_SEQUE, sender: nil)
    }
    
    func beautify() {
        todoItemsTableView.backgroundView = UIImageView(image: UIImage(named: "bg-image-2.png"))
//        todoItemsTableView.separatorStyle = .None
    }


    override func viewDidLoad() {
        super.viewDidLoad()
//        self.todoItemsTableView.editing = true
        
        beautify()
        
        todoItemsTableView.dataSource = self
        todoItemsTableView.delegate = self
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Done, target: self, action: #selector(onAddButton))
        addButton.tintColor = UIColor.blackColor()
        
        self.navigationItem.rightBarButtonItem = addButton

        self.title = todoCategory?.categoryName
        
//        performCRUD()
//        performCRUDTodoItem()
    }
    
    func refresh() {
        self.title = todoCategory?.categoryName
        self.todoItemsTableView.reloadData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if segueIdentifier == Constants.CREATE_TODO_ITEM_SEQUE {
            let todoItemCreateViewController = segue.destinationViewController as! TodoItemCreateViewController
            if let sender = sender {
                let todoItem = sender as! TodoItem
                todoItemCreateViewController.todoItem = todoItem
            }
            todoItemCreateViewController.delegate = self
        }
    }
    // ================== Todo Category CRUD =====================
    func performCRUD() {
//        createTodo()
//        getAllTodos()
//        updateTodoById()
//        getTodoById()
//        deleteTodoById()
    }

//    private func createTodo() {
//        let todoCategory = todoCategoryDataUtil.createTodoCategory()
//        todoCategoryManager.upsertTodoCategory(todoCategory) { (created : Bool, error : NSError?) in
//            if error == nil {
//                print(created)
//            } else {
//                print(error)
//            }
//        }
//    }

    private func getAllTodos() {
        todoCategoryManager.getAllTodoCategories { (todoCategories : [Category], error : NSError?) in
            if error == nil {
                for todoCategory in todoCategories {
                    print(todoCategory)
                }
            }
        }
    }

//    private func updateTodoById() {
//        todoCategoryManager.upsertTodoCategory(todoCategory!) { (updated : Bool, error: NSError?) in
//            if error == nil {
//                print(self.todoCategory)
//            } else {
//                print(error!)
//            }
//        }
//    }
    
//    private func getTodoById() {
//        let id = "aODllSOFRu"
//        todoCategoryManager.getTodoCategoryById(id) { (todoCategory : Category?, error : NSError?) in
//            if error == nil {
//                print(todoCategory!)
//                self.todoCategory = todoCategory
//                self.performCRUDTodoItem()
//                self.todoItemsTableView.reloadData()
//            } else {
//                print(error!)
//            }
//        }
//    }
    
    private func deleteTodoById() {
        let id = "72NzRUilsc"
        todoCategoryManager.deleteTodoCategoryById(id) { (deleted : Bool, error : NSError?) in
            if error == nil {
                print(deleted)
            } else {
                print(error)
            }
        }
    }
    
    // ================== Todo Item CRUD =====================
    
    func performCRUDTodoItem() {
//        createTodoItem()
//        getAllTodoItems()
//        getAllTodoItemsByCategoryId()
//        deleteTodoItem()
//        updateTodoItem()
        
    }
    
    private func createTodoItem() {
        let todoItem = todoCategoryDataUtil.createTodoItem("todo-item-added")
        let categoryId = "b6RZfzOYcu" //todoCategory.id!
        todoItemManager.upsertTodoItem(categoryId, todoItem: todoItem, completion: { (created : Bool, todoItem : TodoItem?, error : NSError?) in
                if error == nil {
                    print(created)
                } else {
                    print(error)
                }
            })
    }

//    private func deleteTodoItem() {
//        let id = "YTzPeSMGOM"
//        todoCategory!.deleteTodoItem(id)
//        todoItemManager.deleteTodoItemById(id) { (deleted : Bool, error : NSError?) in
//            if error == nil {
//                print("todo item deleted ... id: \(id) deleted : \(deleted)")
//                self.updateTodoById()
//            } else {
//                print(error!)
//            }
//        }
//    }

//    private func updateTodoItem() {
//        let id = "CnEaBtvx0a"
//        let todoItem = todoCategory!.getTodoItemById(id)
//        todoItem?.completed = false
//        updateTodoById()
//    }
    
    private func getAllTodoItems() {
        todoItemManager.getAllTodoItems { (todoItems : [TodoItem], error :NSError?) in
            print(todoItems)
            self.todoCategory?.todoItems = todoItems
            self.todoItemsTableView.reloadData()
        }
    }
    
    private func getAllTodoItemsByCategoryId() {
        let id = "CnEaBtvx0a"
        todoItemManager.getAllTodoItemsByCategoryId(id) { (todoItems : [TodoItem], error : NSError?) in
            print(todoItems)
            self.todoCategory?.todoItems = todoItems
            self.todoItemsTableView.reloadData()
        }
    }

    // === Table View ====
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let todoCategory = todoCategory {
            return todoCategory.todoItems.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let todoItemCell = tableView.dequeueReusableCellWithIdentifier(Constants.TODO_ITEM_CELL_ID) as! TodoItemCell
        let todoItem = todoCategory!.todoItems[indexPath.row]
        todoItemCell.todoItem = todoItem
        todoItemCell.todoItemNameLabel.text = todoCategory!.todoItems[indexPath.row].todoItemName
        if (!todoItem.completed) {
            todoItemCell.accessoryType = .None
//            todoItemCell.backgroundColor = UIColor.redColor()
        } else {
            todoItemCell.accessoryType = .Checkmark
//            todoItemCell.backgroundColor = UIColor.greenColor()
        }
        todoItemCell.delegate = self
        todoItemCell.tintColor = UIColor.whiteColor()
        todoItemCell.backgroundColor = UIColor.clearColor()
//        todoItemCell.backgroundColor = ColorUtil.getCellColor(indexPath.row)
        return todoItemCell
    }
        
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected ... \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let todoItemCell = tableView.cellForRowAtIndexPath(indexPath) as! TodoItemCell
        let todoItem = (todoCategory?.todoItems[indexPath.row])! as TodoItem
        todoItem.completed = !todoItem.completed
        todoItemManager.upsertTodoItem((todoCategory?.categoryId)!, todoItem: todoItem) { (updated : Bool, todoItem : TodoItem?, error : NSError?) in
            if error != nil {
                print(error)
            } else {
                print("updated ... \(todoItem)")
            }
        }
        //TODO Need to think what to do if error happened while updating above.
        if (!todoItem.completed) {
            todoItemCell.accessoryType = .None
//            todoItemCell.backgroundColor = UIColor.redColor()
        } else {
            todoItemCell.accessoryType = .Checkmark
//            todoItemCell.backgroundColor = UIColor.greenColor()
        }
        todoItemCell.todoItem = todoItem
    }
    
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        print("inserting")
//    }

//    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
//        var todoItems = self.todoCategory?.todoItems!
//        let itemToMove = todoItems![sourceIndexPath.row]
//        todoItems!.removeAtIndex(sourceIndexPath.row)
//        todoItems!.insert(itemToMove, atIndex: destinationIndexPath.row)
//    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("deleting ...")
            let todoItemToDelete = self.todoCategory?.todoItems[indexPath.row]
            self.todoCategory?.todoItems.removeAtIndex(indexPath.row)
            todoItemManager.deleteTodoItemById((todoItemToDelete?.id)!, completion: { (deleted : Bool, error : NSError?) in
                if error == nil {
                    print(deleted)
                } else {
                    print(error)
                }
            })
            self.todoItemsTableView.reloadData()
        }
    }
}

extension TodoDetailsViewController : TodoItemCreateDelegate {
    
    func onSave(todoItem: TodoItem) {
        if (todoItem.id != nil) {
            //update todoitem flow
            findAndRemove(todoItem)
        }
        todoItemManager.upsertTodoItem((self.todoCategory?.categoryId)!, todoItem: todoItem) { (created : Bool, todoItem: TodoItem?, error : NSError?) in
            if error == nil {
                print("created ... \(todoItem)")
                self.todoCategory?.todoItems.append(todoItem!)
                self.todoItemsTableView.reloadData()
            } else {
                print(error)
            }
        }
    }
    
    func findAndRemove(todoItem : TodoItem) {
        let todoItemIndex = findIndex(todoItem)
        if let todoItemIndex = todoItemIndex {
            self.todoCategory?.todoItems.removeAtIndex(todoItemIndex)
        }
    }
    
    func findIndex(todoItem : TodoItem) -> Int? {
        let todoItems = self.todoCategory?.todoItems
        for i in 0 ..< todoItems!.count  {
            let existingTodoItem = todoItems![i]
            if existingTodoItem.id == todoItem.id {
                return i
            }
        }
        return nil
    }
}

extension TodoDetailsViewController : TodoItemCellDelegate {
    func onLongPress(todoItem : TodoItem) {
        performSegueWithIdentifier(Constants.CREATE_TODO_ITEM_SEQUE, sender: todoItem)
    }
}

