//
//  NavigationViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/12/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    var corner_left: UIImageView!
    var corner_right: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().backItem?.hidesBackButton = false
        UINavigationBar.appearance().tintColor = UIColor.primaryAccent(alpha: 1.0)
        UINavigationBar.appearance().translucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bg_nav"), forBarMetrics: UIBarMetrics.Default)

        
        if let font = UIFont(name: "SanFranciscoDisplay-Medium", size: 17) {
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: font]
        }
        
        

        
        
        
        // CORNER MASKS
        corner_left = UIImageView(image: UIImage(named: "corner_left"))
        corner_left.frame = CGRect(x: 0, y: 0, width: 6, height: 6)
        view.addSubview(corner_left)
        
        corner_right = UIImageView(image: UIImage(named: "corner_right"))
        corner_right.frame = CGRect(x: screenSize.width - 6, y: 0, width: 6, height: 6)
        view.addSubview(corner_right)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func didTapAdd(sender:UIButton){
        //
    }
}
