//
//  StacksViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/10/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

class StacksViewController: UIViewController, UINavigationControllerDelegate {

    var btn_stacks : UIButton!
    var stroke_stacks : UIView!
    var chevron : UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Stacks"

        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        
        
        // COMPOSE
        
        btn_stacks = UIButton(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: 100))
        btn_stacks.setTitle("Stack", forState: .Normal)
        btn_stacks.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btn_stacks.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        btn_stacks.backgroundColor = UIColor.clearColor()
        btn_stacks.addTarget(self, action: "didTapStacks:", forControlEvents: .TouchUpInside)
        btn_stacks.titleLabel!.font = UIFont.tertiaryFont()
        btn_stacks.setTitleColor(UIColor.primaryColor(alpha: 1.0), forState: UIControlState.Normal)
        view.addSubview(btn_stacks)
        
        // STROKE COMPOSE
        
        stroke_stacks = UIView(frame: CGRect(x: 20, y: 100, width: screenSize.width - 40, height:1))
        stroke_stacks.backgroundColor = UIColor.strokeColor(alpha: 1.0)
        btn_stacks.addSubview(stroke_stacks)

        
        // CHEVRON
        
        chevron = UIImageView(image: UIImage(named: "chevron"))
        chevron.frame = CGRect(x: screenSize.width - 28, y: 44, width: 8.0, height: 13.0)
        btn_stacks.addSubview(chevron)
   
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didTapStacks(sender:UIButton){
        let homeVC: HomeViewController = HomeViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }

}
