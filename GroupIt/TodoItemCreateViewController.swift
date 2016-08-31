//
//  TodoItemCreateViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/21/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol TodoItemCreateDelegate {
    func onSave(todoItem : TodoItem)
}

class TodoItemCreateViewController: UIViewController {

    
    @IBOutlet weak var todoItemNameTextField: UITextField!
    
    
    @IBOutlet weak var todoItemDescriptionTextField: UITextField!
    
    var delegate : TodoItemCreateDelegate?
    
    
    var todoItem : TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepopulateData()
    }
    
    func prepopulateData() {
        if let todoItem = todoItem {
            self.todoItemNameTextField.text = todoItem.todoItemName
        }
    }
    
    @IBAction func onSaveButtonTap(sender: AnyObject) {
        print("saving todo item ... ")
        let updatedTodoItem = getUpdatedTodoItem()
        self.delegate?.onSave(updatedTodoItem)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func getUpdatedTodoItem() -> TodoItem {
        let todoItem = TodoItem()
        todoItem.id = self.todoItem?.id
        todoItem.todoItemName = todoItemNameTextField.text
        todoItem.completed = false
        todoItem.user = User.currentUser
        return todoItem
    }
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        print("cancelling todo item creation ... ")
        self.dismissViewControllerAnimated(true, completion: {})
    }
}