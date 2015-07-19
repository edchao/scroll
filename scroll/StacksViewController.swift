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
    var table_stacks: UITableView! = UITableView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Stacks"
        
        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        
        
        // SETUP TABLE
        
        table_stacks.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        table_stacks.rowHeight = 100
        table_stacks.delegate = self
        table_stacks.dataSource = self
        table_stacks.registerClass(StacksTableViewCell.self, forCellReuseIdentifier: "cell")
        table_stacks.separatorInset = UIEdgeInsetsMake(15, 15, 15, 15)
        table_stacks.separatorColor = UIColor.strokeColor(alpha: 1)
        table_stacks.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        table_stacks.tableHeaderView = nil
        table_stacks.backgroundColor = UIColor.clearColor()
        self.view.addSubview(table_stacks)
        table_stacks.tableFooterView = UIView(frame: CGRect.zeroRect)
        self.table_stacks.rowHeight = UITableViewAutomaticDimension

        
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
    

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        

        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StacksTableViewCell
        cell.label_text.text = "Stack"
        cell.accessoryType = .DisclosureIndicator
        cell.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        

        return cell

    }
}
