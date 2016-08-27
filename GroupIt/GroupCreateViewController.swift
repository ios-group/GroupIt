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
    
    var group : Group?
    var delegate : GroupCreateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepopulateData()
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
