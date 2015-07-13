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
        
        if let font = UIFont(name: "SanFranciscoDisplay-Medium", size: 17) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
