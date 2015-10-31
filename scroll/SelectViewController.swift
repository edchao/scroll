//
//  SelectViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/26/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse



class SelectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate {

    var table_stacks: UITableView! = UITableView()
    var btn_cancel : UIBarButtonItem!
    var alert : UIAlertView!
    var btn_add : UIBarButtonItem!

    
    // PARSE VARIABLES
    var stacks : [PFObject]! = []
    var stackId : String! = "000"
    
    
    // DELEGATE VARS
    
    var indexPath: NSIndexPath!
    var noteId : String! = "000"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Select Short Stack"
        
        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(1.0)
        
        
        // SETUP TABLE
        
        table_stacks.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        table_stacks.rowHeight = 100
        table_stacks.delegate = self
        table_stacks.dataSource = self
        table_stacks.registerClass(StacksTableViewCell.self, forCellReuseIdentifier: "cell")
        table_stacks.separatorInset = UIEdgeInsetsMake(15, 15, 15, 15)
        table_stacks.separatorColor = UIColor.strokeColor(1)
        table_stacks.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        table_stacks.tableHeaderView = nil
        table_stacks.backgroundColor = UIColor.clearColor()
        self.view.addSubview(table_stacks)
        table_stacks.tableFooterView = UIView(frame: CGRect.zero)
        self.table_stacks.rowHeight = UITableViewAutomaticDimension
        
        // ALERT
        
        
        alert = UIAlertView(
            title: "New Short Stack",
            message: "Enter a name for this Short Stack",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Save"
        )
        
        // BUTTONS
        
        btn_cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapCancel:")
        self.navigationController?.topViewController!.navigationItem.leftBarButtonItem = btn_cancel
        
        btn_add = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapAdd:")
        self.navigationController?.topViewController!.navigationItem.rightBarButtonItem = btn_add

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didTapCancel(sender:UIBarButtonItem){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
    
    // VIEW PAINTING
    
    override func viewWillAppear(animated: Bool) {
        getStacks { () -> Void in
            //
        }
        
    }
    
    
    // QUERIES
    
    func getStacks(completion:() -> Void){
        var query = PFQuery(className: "Stack")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.addAscendingOrder("createdAt")
        query.cachePolicy = .NetworkElseCache
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            UIView.animateWithDuration(0, animations: { () -> Void in
                self.stacks = objects! as [PFObject]
                self.table_stacks.reloadData()
                }, completion: { (Bool) -> Void in
                    //
            })
            
        }
    }

    
    
    func didTapAdd(sender:UIBarButtonItem){
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.textFieldAtIndex(0)?.placeholder = "Trip to Taipei"
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex {
            print ("cancelled")
        }
        else{
            var stackName = alertView.textFieldAtIndex(0)!.text
            self.addStack(stackName!)
        }
    }
    
    
    func addStack(stackName : String) {
        print(stackName)
        
        var shortStack = PFObject(className: "Stack")
        shortStack.ACL = PFACL(user: PFUser.currentUser()!)
        shortStack["text"] = stackName
        shortStack["user"] = PFUser.currentUser()
        
        shortStack.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("saved Stack")
            self.getStacks({ () -> Void in
                //
            })
        }
        
        
    }

    
    func didSelectStack(sender:AnyObject, indexPath: NSIndexPath){
        
        
        var query = PFQuery(className:"Note")
        query.getObjectInBackgroundWithId(self.noteId) {
            (note: PFObject?, error: NSError?) -> Void in
            if error == nil && note != nil {
                note!.ACL = PFACL(user: PFUser.currentUser()!)
                var relation = note!.relationForKey("stacks")
                relation.addObject(self.stacks[indexPath.row])
                note!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                    print("saved to short stack")
                    self.dismissViewControllerAnimated(true, completion: { () -> Void in
                        //
                    })
                }
                
            } else {
                print(error)
            }
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        didSelectStack(self, indexPath: indexPath)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stacks.count
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var stack = self.stacks[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StacksTableViewCell
        cell.label_text.text = stack["text"] as! String!
        
        cell.backgroundColor = UIColor.clearColor()
        
        
        cell.sizeToFit()
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell

        
    }


}
