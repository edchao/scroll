//
//  AppDelegate.swift
//  scroll
//
//  Created by Ed Chao on 6/20/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            window.backgroundColor = UIColor.whiteColor()
            window.rootViewController = HomeViewController()
            window.makeKeyAndVisible()
        }
        return true
    }
    
    
}

