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
    var keys: NSDictionary?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        

        
        if let path = NSBundle.mainBundle().pathForResource("keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }
        if let dict = keys {
            let applicationId = keys?["parseApplicationId"] as? String
            let clientKey = keys?["parseClientKey"] as? String
            
            // Initialize Parse.
            Parse.setApplicationId(applicationId!, clientKey: clientKey!)
        }
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont.primaryFont()], forState: UIControlState.Normal)
            window.backgroundColor = UIColor.whiteColor()
            window.rootViewController = AuthViewController()
            window.makeKeyAndVisible()
        }

        return true
    }
    
    
    
}

