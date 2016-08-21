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
    }
    
    @IBAction func onSaveButtonTap(sender: AnyObject) {
        print("saving todo item ... ")
        initTodoItem()
        self.delegate?.onSave(todoItem!)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func initTodoItem() {
        todoItem = TodoItem()
        todoItem?.todoItemName = todoItemNameTextField.text
        todoItem?.completed = false
    }
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        print("cancelling todo item creation ... ")
        self.dismissViewControllerAnimated(true, completion: {})
    }
}