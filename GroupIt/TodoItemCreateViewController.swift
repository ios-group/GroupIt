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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var delegate : TodoItemCreateDelegate?
    var todoItem : TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItemNameTextField.delegate = self
        todoItemDescriptionTextField.delegate = self
        beautify()
        prepopulateData()
    }
    
    func beautify() {
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "bg-image-2")
        self.view.insertSubview(backgroundImage, atIndex: 0)

        TextFieldTheme.beautifyTextField(todoItemNameTextField, placeHolder: "name")
        TextFieldTheme.beautifyTextField(todoItemDescriptionTextField, placeHolder: "description")

        ButtonTheme.beautifyButton(saveButton)
        ButtonTheme.beautifyButton(cancelButton)
        
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

extension TodoItemCreateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
