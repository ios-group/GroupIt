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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItemsTableView.dataSource = self
        todoItemsTableView.delegate = self
        
//        performCRUD()
    }
    
    // ================== Todo Category CRUD =====================
    func performCRUD() {
//        createTodo()
//        getAllTodos()
//        updateTodoById()
        getTodoById()
//        deleteTodoById()
    }

    private func createTodo() {
        let todoCategory = todoCategoryDataUtil.createTodoCategory()
        todoCategoryManager.createTodoCategory(todoCategory) { (created : Bool, error : NSError?) in
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
        todoCategoryManager.updateTodoCategory(todoCategory!.id!, todoCategory: todoCategory!) { (updated : Bool, error: NSError?) in
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
//        deleteTodoItem()
        updateTodoItem()
        
    }
    
    private func createTodoItem() {
        let todoItem = todoCategoryDataUtil.createTodoItem("todo-item-added")
        todoCategory!.addTodoItem(todoItem)
        updateTodoById()
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
        todoItem?.isCompleted = false
        updateTodoById()
    }
    
    // ==================  =====================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

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
        todoItemCell.todoItemNameLabel.text = todoCategory!.todoItems[indexPath.row].todoItemName
        return todoItemCell
    }
}

