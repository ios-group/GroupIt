//
//  SignUpViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var fullNameField: UITextField!
   
    var user : User?
    let userManager = UserManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUpButton(sender: AnyObject) {
        print("inside signup action")

        let user = User()
        user.username = fullNameField.text
        user.email = emailField.text
        user.password = passwordField.text
       
        userManager.upsertUser(user) { (saved : Bool, error : NSError?) in
            if error == nil {
                print(saved)
                self.user = user
                self.performSegueWithIdentifier(Constants.SIGNUP_GROUPS_SEGUE, sender: self)
            } else {
                print(error)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("prepare for segue - signup -> groups")
        
//        if segue.identifier == Constants.SIGNUP_GROUPS_SEGUE {
//            let groupsViewController = segue.destinationViewController as! GroupsViewController
//        }
        
    }
    

}
