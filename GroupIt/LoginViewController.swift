//
//  LoginViewController.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    var userManager = UserManager()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beautify()
    }
    
    func beautify(){
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "bg-image-2")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        usernameTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        loginButton.setButtonBorder()
        signUpButton.setButtonBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        //Need to add logic for verifying user
        
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        userManager.loginUser(username!, password: password!) { (user: User?, error: NSError?) in
            if error == nil {
                print("logged in User!!!")
                self.user = user!
                //Set the currentUser in NSUserDefaults for session control
                User.currentUser = user!
                print(User.currentUser?.email)
                self.performSegueWithIdentifier(Constants.LOGIN_GROUPS_SEGUE, sender: self)
            }else {
              //Login Failed
                print("Login Failed Please try again")
                print(error)
            }
        }
    }
    
    @IBAction func onSignUpButton(sender: AnyObject) {
        self.performSegueWithIdentifier(Constants.SIGNUP_USER_SEGUE, sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
