//
//  GroupCreateViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/21/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol GroupCreateDelegate {
    func onSave(group : Group)
}

class GroupCreateViewController: UIViewController {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupDescriptionTextField: UITextField!
    @IBOutlet weak var groupCancelButton: UIButton!
    @IBOutlet weak var groupSaveButton: UIButton!
    
    var group : Group?
    var delegate : GroupCreateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupNameTextField.delegate = self
        groupDescriptionTextField.delegate = self
        beautify()
        prepopulateData()
    }
    
    func beautify(){
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "bg-image-2")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        groupNameTextField.setBottomBorder()
        groupDescriptionTextField.setBottomBorder()
        groupSaveButton.setButtonBorder()
        groupCancelButton.setButtonBorder()
        
        TextFieldTheme.beautifyTextField(groupNameTextField, placeHolder: "name")
        TextFieldTheme.beautifyTextField(groupDescriptionTextField, placeHolder: "description")
    }
    
    
    func prepopulateData() {
        if let group = group {
            groupNameTextField.text = group.groupName
        }
    }

    @IBAction func onSaveButtonTap(sender: AnyObject) {
        print("saving group ... ")
        let updatedGroup = getUpdatedGroup()
        self.delegate?.onSave(updatedGroup)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func getUpdatedGroup() -> Group {
        let group = Group()
        group.groupId = self.group?.groupId
        group.groupName = self.groupNameTextField.text
        //print("Setting current groupOwner in Create Group!")
        group.groupDescription = self.groupDescriptionTextField.text
        group.groupOwner = User.currentUser!
        return group
    }
    
    @IBAction func onCancelButtonTap(sender: AnyObject) {
        print("cancelling group ... ")
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
}

extension GroupCreateViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
