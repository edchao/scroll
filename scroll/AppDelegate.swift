//
//  AppDelegate.swift
//  scroll
//
//  Created by Ed Chao on 6/20/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("KsQENFMSzQvdPTlqS8F4qWGivG9g322jk9k9Ql3X",
            clientKey: "V8HcFooWmNZds6jLRMvFCbo7aczXGg04thTEcHGY")
        PFUser.enableAutomaticUser()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.backgroundColor = UIColor.whiteColor()
            window.rootViewController = HomeViewController()
            window.makeKeyAndVisible()
        }

        return true
    }
    
    
    
}

