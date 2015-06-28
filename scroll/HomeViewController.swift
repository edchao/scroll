//
//  HomeViewController.swift
//  scroll
//
//  Created by Ed Chao on 6/20/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse

extension UIColor {
    class func primaryColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 49/255, green: 53/255, blue: 57/255, alpha: alpha)
    }
    
    class func secondaryColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 113/255, green: 121/255, blue: 129/255, alpha: alpha)
    }
    
    class func primaryAccent(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red:  74/255, green: 144/255, blue: 226/255, alpha: alpha)
    }
    
    class func secondaryAccent(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 208/255, green: 72/255, blue: 72/255, alpha: alpha)
    }
    
    class func neutralColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: alpha)
    }
    
    class func strokeColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: alpha)
    }
}

extension UIFont {
    
    class func primaryFont() -> UIFont {
        return UIFont(name: "SanFranciscoDisplay-Regular", size: 17.0)!
    }
    
    class func secondaryFont() -> UIFont {
        return UIFont(name: "SanFranciscoDisplay-Medium", size: 17.0)!
    }
    
}

var data : Array! = [
    "Hello World",
    "this is a new thought!"
]

let screenSize : CGRect = UIScreen.mainScreen().bounds

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, ComposeDelegate {

    // CLASS VARS
    
    var table_home : UITableView = UITableView()
    var contentContainer : UIView!
    var composeVC: ComposeViewController! = ComposeViewController()
    var tableHeight : CGFloat! = 0
    
    
    // PARSE VARIABLES
    var notes : [PFObject]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 0.5)
        
        
        // TABLE SETUP
        
        table_home.frame = CGRectMake(0, 20, screenSize.width, screenSize.height-20);
        table_home.rowHeight = 100
        table_home.delegate = self
        table_home.dataSource = self
        table_home.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        table_home.separatorInset = UIEdgeInsetsMake(15, 15, 15, 15)
        table_home.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        table_home.tableHeaderView = nil
        table_home.backgroundColor = UIColor.neutralColor(alpha: 0)
        view.addSubview(table_home)
        
        // SETUP CONTAINER
        contentContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
        contentContainer.backgroundColor = UIColor.neutralColor(alpha: 0)
        view.addSubview(contentContainer)
        
        // ADD CHILD VC
        self.addChildViewController(self.composeVC)
        self.composeVC.delegate = self
        self.composeVC.view.frame = self.contentContainer.frame
        self.contentContainer.addSubview(self.composeVC.view)
        
        table_home.tableFooterView = UIView(frame: CGRect.zeroRect)
        self.table_home.rowHeight = UITableViewAutomaticDimension
        
        // SETUP LOGIN CONTAINER SHIFT
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        getNotes { () -> Void in
            self.layoutTextView()
        }
    }
    
    // DELEGATE METHOD
    
    func reloadHomeTable(sender:ComposeViewController){
        self.getNotes { () -> Void in
            self.layoutTextView()
            println("reloaded table")
        }
        
    }

    // QUERIES
    
    func getNotes(completion:() -> Void){
        var query = PFQuery(className: "Note")
        query.addAscendingOrder("updatedAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            UIView.animateWithDuration(0, animations: { () -> Void in
                self.notes = objects as! [PFObject]?
                self.table_home.reloadData()
            }, completion: { (Bool) -> Void in
                completion()
            })

        }
    }
    
    // MEMORY HANDLING
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // KEYBOARD BEHAVIOR
    
        func keyboardWillShow(notification: NSNotification!) {
            var userInfo = notification.userInfo!
            var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
            var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            var animationDuration = durationValue.doubleValue
            var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            var animationCurve = curveValue.integerValue
    
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
                self.contentContainer.frame.size.height = self.view.frame.height - kbSize.height - self.table_home.contentSize.height - 20
                }, completion: nil)
        }
    
        func keyboardWillHide(notification: NSNotification!) {
            var userInfo = notification.userInfo!
            var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
            var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            var animationDuration = durationValue.doubleValue
            var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            var animationCurve = curveValue.integerValue
    
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
                self.contentContainer.frame.size.height = self.view.frame.height - kbSize.height - self.table_home.contentSize.height - 20
                }, completion: nil)
        }
    
    
    // CONTAINER SCROLL WITH TABLE
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.contentContainer != nil {
            self.contentContainer.frame.origin.y = self.table_home.contentSize.height - scrollView.contentOffset.y  + 20
        }
        
    }
    
    // LAYOUT TEXTVIEW
    
    func layoutTextView(){
        self.contentContainer.frame.origin.y = self.table_home.contentSize.height + 20
    }

    
    // TABLE METHODS

    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    // TABLE POPULATE CELLS
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var note = self.notes[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.label_text.text = note["text"] as! String!
        
        tableHeight = self.table_home.contentSize.height
        
        cell.sizeToFit()
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }

    // RANDOM
    // ------
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    

}
