//
//  AppDelegate.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private func initParse() {
        
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        setAppTheme()
        registerParseSubclasses()
        
        // ============= instantiate parse ==============
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = Constants.parseAppId
                configuration.clientKey = nil  // set to nil assuming you have not set clientKey
                configuration.server = Constants.parseServer
            })
        )
        
        // ============= check for current logged in user ==============
        if User.currentUser != nil {
            print("There is a current user")
            let storyboard = UIStoryboard(name: Constants.GROUPS_STORYBOARD_NAME, bundle: nil)
            let groupsViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.GROUPS_NAV_VIEW_CONTROLLER_ID) as! UINavigationController
            
            window!.rootViewController = groupsViewController
        }
        
        //Go to LoginViewController when logoutNotification is set
        NSNotificationCenter.defaultCenter().addObserverForName(User.userDidLogoutNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (NSNotification) in
            
            let storyboard = UIStoryboard(name: Constants.LOGIN_STORYBOARD_NAME, bundle: nil)
            let loginViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.LOGIN_VIEW_CONTROLLER_ID)
            self.window?.rootViewController = loginViewController
        }
        return true
    }
    
    func setAppTheme() {
        UINavigationBar.appearance().barTintColor = ColorTheme.NAV_BAR_COLOR
        UINavigationBar.appearance().tintColor = UIColor.blackColor()
    }
    
    
    func registerParseSubclasses() {
        TodoItemDO.registerSubclass()
        ImageItemDO.registerSubclass()
        CategoryDO.registerSubclass()
        GroupDO.registerSubclass()
        UserDO.registerSubclass()
        GroupUserRelationDO.registerSubclass()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

