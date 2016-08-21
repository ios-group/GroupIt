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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItemsTableView.dataSource = self
        todoItemsTableView.delegate = self
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(onAddButton))
        self.navigationItem.rightBarButtonItem = addButton

        self.title = todoCategory?.todoName
        
//        performCRUD()
//        performCRUDTodoItem()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueIdentifier = segue.identifier
        if segueIdentifier == Constants.CREATE_TODO_ITEM_SEQUE {
            let todoItemCreateViewController = segue.destinationViewController as! TodoItemCreateViewController
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

    private func createTodo() {
        let todoCategory = todoCategoryDataUtil.createTodoCategory()
        todoCategoryManager.upsertTodoCategory(todoCategory) { (created : Bool, error : NSError?) in
            if error == nil {
                print(created)
            } else {
                print(error)
            }
        }
    }

    private func getAllTodos() {
        todoCategoryManager.getAllTodoCategories { (todoCategories : [TodoCategory], error : NSError?) in
            if error == nil {
                for todoCategory in todoCategories {
                    print(todoCategory)
                }
            }
        }
    }

    private func updateTodoById() {
        todoCategoryManager.upsertTodoCategory(todoCategory!) { (updated : Bool, error: NSError?) in
            if error == nil {
                print(self.todoCategory)
            } else {
                print(error!)
            }
        }
    }
    
    private func getTodoById() {
        let id = "aODllSOFRu"
        todoCategoryManager.getTodoCategoryById(id) { (todoCategory : TodoCategory?, error : NSError?) in
            if error == nil {
                print(todoCategory!)
                self.todoCategory = todoCategory
                self.performCRUDTodoItem()
                self.todoItemsTableView.reloadData()
            } else {
                print(error!)
            }
        }
    }
    
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
            todoItemManager.upsertTodoItem(categoryId, todoItem: todoItem, completion: { (created : Bool, error : NSError?) in
                if error == nil {
                    print(created)
                } else {
                    print(error)
                }
            })
    }

    private func deleteTodoItem() {
        let id = "YTzPeSMGOM"
        todoCategory!.deleteTodoItem(id)
        todoItemManager.deleteTodoItemById(id) { (deleted : Bool, error : NSError?) in
            if error == nil {
                print("todo item deleted ... id: \(id) deleted : \(deleted)")
                self.updateTodoById()
            } else {
                print(error!)
            }
        }
    }

    private func updateTodoItem() {
        let id = "CnEaBtvx0a"
        let todoItem = todoCategory!.getTodoItemById(id)
        todoItem?.completed = false
        updateTodoById()
    }
    
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
            todoItemCell.backgroundColor = UIColor.redColor()
        } else {
            todoItemCell.accessoryType = .Checkmark
            todoItemCell.backgroundColor = UIColor.greenColor()
        }
        
        return todoItemCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("selected ... \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let todoItemCell = tableView.cellForRowAtIndexPath(indexPath) as! TodoItemCell
        let todoItem = (todoCategory?.todoItems[indexPath.row])! as TodoItem
        todoItem.completed = !todoItem.completed
        todoItemManager.upsertTodoItem((todoCategory?.getID())!, todoItem: todoItem) { (updated : Bool, error : NSError?) in
            if error != nil {
                print(error)
            } else {
                print("updated ... \(todoItem)")
            }
        }
        //TODO Need to think what to do if error happened while updating above.
        if (!todoItem.completed) {
            todoItemCell.accessoryType = .None
            todoItemCell.backgroundColor = UIColor.redColor()
        } else {
            todoItemCell.accessoryType = .Checkmark
            todoItemCell.backgroundColor = UIColor.greenColor()
        }
        todoItemCell.todoItem = todoItem
    }
}

extension TodoDetailsViewController : TodoItemCreateDelegate {
    
    func onSave(todoItem: TodoItem) {
        self.todoCategory?.todoItems.append(todoItem)
        self.todoItemsTableView.reloadData()
        todoItemManager.upsertTodoItem((self.todoCategory?.getID())!, todoItem: todoItem) { (created : Bool, error : NSError?) in
            if error == nil {
                print("created ... \(todoItem)")
            } else {
                print(error)
            }
        }
    }
}

