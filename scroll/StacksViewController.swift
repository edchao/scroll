//
//  StacksViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/10/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse

class StacksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIAlertViewDelegate {

    var btn_logout : UIBarButtonItem!
    var btn_stacks : UIButton!
    var btn_add : UIBarButtonItem!

    var stroke_stacks : UIView!
    var chevron : UIImageView!
    var table_stacks: UITableView! = UITableView()
    
    var alert : UIAlertView!
    
    // PARSE VARIABLES
    var stacks : [PFObject]! = []
    var stackId : String! = "000"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "Stacks"
        
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
        table_stacks.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        table_stacks.tableHeaderView = UIView(frame: CGRectMake(0, 0, screenSize.width, 11))
        table_stacks.backgroundColor = UIColor.clearColor()
        self.view.addSubview(table_stacks)
        self.table_stacks.rowHeight = UITableViewAutomaticDimension

        // BUTTONS
        
        btn_add = UIBarButtonItem(title: "Create", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapAdd:")
        self.navigationController?.topViewController!.navigationItem.rightBarButtonItem = btn_add
        
        btn_logout = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapLogout:")
        self.navigationController?.topViewController!.navigationItem.leftBarButtonItem = btn_logout
        
        
        // ALERT
        
        
        alert = UIAlertView(
            title: "New Short Stack",
            message: "Enter a name for this Short Stack",
            delegate: self,
            cancelButtonTitle: "Cancel",
            otherButtonTitles: "Save"
        )

        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // VIEW PAINTING
    
    override func viewWillAppear(animated: Bool) {
        table_stacks.tableHeaderView!.frame = CGRectMake(0, 0, screenSize.width, 11)
        getStacks { () -> Void in
            //
        }
    }
    
    // QUERIES
    
    func getStacks(completion:() -> Void){
        let query = PFQuery(className: "Stack")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.addDescendingOrder("updatedAt")
//        query.cachePolicy = .NetworkElseCache
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            UIView.animateWithDuration(0, animations: { () -> Void in
                self.stacks = objects
                self.table_stacks.reloadData()
                }, completion: { (Bool) -> Void in
                    //
            })
            
        }
    }
    
    func didTapLogout(sender:UIBarButtonItem){
        PFUser.logOut()
        dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
    
    func didTapAdd(sender:UIBarButtonItem){
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.textFieldAtIndex(0)?.placeholder = "Trip to Taipei"
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == alertView.cancelButtonIndex {
            print("cancelled")
        }
        else{
            let stackName = alertView.textFieldAtIndex(0)!.text
            self.addStack(stackName!)
        }
    }
    
    
    func addStack(stackName : String) {
        print(stackName)
        
        let shortStack = PFObject(className: "Stack")
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
    
    // TABLEVIEW METHODS
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0 {
            let homeVC: HomeViewController = HomeViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(homeVC, animated: true)
        }else{
            let shortVC: ShortStackViewController = ShortStackViewController(nibName: nil, bundle: nil)
            shortVC.title = self.stacks[indexPath.row]["text"] as! String!
            shortVC.stackObject = self.stacks[indexPath.row]
            self.navigationController?.pushViewController(shortVC, animated: true)
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return self.stacks.count
        }
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }else{
            return "SHORT STACKS"
        }
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 22
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }else{
            let view : UIView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 22))
            let label : UILabel = UILabel(frame: CGRectMake(20, 0, tableView.frame.size.width, 22))
            let strokeTop : UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
            let strokeBot : UIView = UIView(frame: CGRect(x: 0, y: 21, width: tableView.frame.size.width, height: 1))
            strokeBot.backgroundColor = UIColor.strokeColor(1.0)
            strokeTop.backgroundColor = UIColor.strokeColor(1.0)
            label.font = UIFont.primaryFontSmall()
            label.textColor = UIColor.primaryColor(0.7)
            label.text = "SHORT STACKS"
            view.addSubview(label)
            view.addSubview(strokeTop)
            view.addSubview(strokeBot)
            view.backgroundColor = UIColor.headerColor(1.0)
            return view
        }
    
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let query = PFQuery(className:"Stack")
            self.stackId = self.stacks[indexPath.row].objectId
            query.getObjectInBackgroundWithId(self.stackId) {
                (note: PFObject?, error: NSError?) -> Void in
                if error == nil && note != nil {
                    print(note)
                    
                    note?.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        if error == nil && success == true {
                            self.stacks.removeAtIndex(indexPath.row)
                            self.table_stacks.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                            
                            self.getStacks({ () -> Void in
                                //
                            })
                            
                        }
                        else {
                            print(error)
                        }
                    })
                } else {
                    print(error)
                }
            }
            
            
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! StacksTableViewCell
        if indexPath.section == 0 {
            cell.label_text.text = "Stack"
            cell.accessoryType = .DisclosureIndicator
            cell.backgroundColor = UIColor.neutralColor(1.0)
        }else{
            let stack = self.stacks[indexPath.row]
            cell.label_text.text = stack["text"] as! String!
            cell.accessoryType = .DisclosureIndicator
            cell.backgroundColor = UIColor.clearColor()
            cell.sizeToFit()
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            
            return cell
        }
        return cell

        

    }
}
