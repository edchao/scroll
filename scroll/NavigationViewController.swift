//
//  NavigationViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/12/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().backItem?.hidesBackButton = false
        UINavigationBar.appearance().tintColor = UIColor.primaryAccent(alpha: 1.0)
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bg_nav"), forBarMetrics: UIBarMetrics.Default)

        
        if let font = UIFont(name: "SanFranciscoDisplay-Medium", size: 17) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func didTapAdd(sender:UIButton){
        //
    }
}
