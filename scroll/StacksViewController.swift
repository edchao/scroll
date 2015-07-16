//
//  StacksViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/10/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

class StacksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    var btn_stacks : UIButton!
    var stroke_stacks : UIView!
    var chevron : UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Stacks"
        
        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        
        let tableView = UITableView(frame: self.view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        self.view.addSubview(tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let homeVC: HomeViewController = HomeViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // EW REFACTOR ME
        // XXX TODO
        let cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("StacksCell")
        if let cell = cell as? UITableViewCell {
            return cell
        } else {
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 64, width: screenSize.width, height: 100))
            cell.textLabel?.text = "Stack"
            //           cell.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            //            cell.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.font = UIFont.tertiaryFont()
            cell.textLabel?.textColor = UIColor.primaryColor(alpha: 1.0)
            //            cell.setTitleColor(UIColor.primaryColor(alpha: 1.0), forState: UIControlState.Normal)
            //           cell.addSubview(btn_stacks)
            
            // STROKE COMPOSE
            
            stroke_stacks = UIView(frame: CGRect(x: 20, y: 100, width: screenSize.width - 40, height:1))
            stroke_stacks.backgroundColor = UIColor.strokeColor(alpha: 1.0)
            cell.addSubview(stroke_stacks)
            
            
            // CHEVRON
            
            chevron = UIImageView(image: UIImage(named: "chevron"))
            chevron.frame = CGRect(x: screenSize.width - 28, y: 44, width: 8.0, height: 13.0)
            cell.addSubview(chevron)
            return cell
        }
    }
}
