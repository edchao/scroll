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
        return UIColor(red: 64/255, green: 63/255, blue: 63/255, alpha: alpha)
    }
    
    class func secondaryColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 113/255, green: 121/255, blue: 129/255, alpha: alpha)
    }
    
    class func primaryAccent(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red:  160/255, green: 203/255, blue: 185/255, alpha: alpha)
    }
    
    class func secondaryAccent(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 208/255, green: 72/255, blue: 72/255, alpha: alpha)
    }
    
    class func neutralColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: alpha)
    }
    
    class func strokeColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: alpha)
    }
}

extension UIFont {
    
    class func primaryFont() -> UIFont {
        return UIFont(name: "SanFranciscoDisplay-Regular", size: 18.0)!
    }
    
    class func secondaryFont() -> UIFont {
        return UIFont(name: "SanFranciscoDisplay-Medium", size: 18.0)!
    }
    
    class func tertiaryFont() -> UIFont {
        return UIFont(name: "PTSerif-Regular", size: 18.0)!
    }
    
}



let screenSize : CGRect = UIScreen.mainScreen().bounds

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, ComposeDelegate, UIViewControllerTransitioningDelegate {

    // CLASS VARS
    
    var table_home : UITableView = UITableView()
    var contentContainer : UIView!
    var composeVC: ComposeViewController! = ComposeViewController()
    var tableHeight : CGFloat! = 0
    var btn_compose : UIButton!
    var stroke_compose: UIView!

    
    
    // PARSE VARIABLES
    var notes : [PFObject]! = []
    var noteId : String! = "000"
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        
        
        // TABLE SETUP
        
        table_home.frame = CGRectMake(0, 20, screenSize.width, screenSize.height-20);
        table_home.rowHeight = 100
        table_home.delegate = self
        table_home.dataSource = self
        table_home.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        table_home.separatorInset = UIEdgeInsetsMake(15, 15, 15, 15)
        table_home.separatorColor = UIColor.strokeColor(alpha: 1)
        table_home.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        table_home.tableHeaderView = nil
        table_home.backgroundColor = UIColor.clearColor()
        view.addSubview(table_home)
        table_home.tableFooterView = UIView(frame: CGRect.zeroRect)
        self.table_home.rowHeight = UITableViewAutomaticDimension
        
        

        // COMPOSE
        
        btn_compose = UIButton(frame: CGRect(x: 0, y: screenSize.height - 50, width: screenSize.width, height: 50))
        btn_compose.setTitle("Write something...", forState: .Normal)
        btn_compose.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        btn_compose.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0)
        btn_compose.backgroundColor = UIColor.whiteColor()
        btn_compose.addTarget(self, action: "didTapCompose:", forControlEvents: .TouchUpInside)
        btn_compose.titleLabel!.font = UIFont.primaryFont()
        btn_compose.setTitleColor(UIColor.primaryColor(alpha: 0.5), forState: UIControlState.Normal)
        view.addSubview(btn_compose)
        
        

        // STROKE COMPOSE
        
        stroke_compose = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        stroke_compose.backgroundColor = UIColor.primaryColor(alpha: 0.1)
        btn_compose.addSubview(stroke_compose)
        
        
        // MISC INIT
        
//        printFonts()

    }
    
    // VIEW PAINTING
    
    override func viewWillAppear(animated: Bool) {
        getNotes { () -> Void in
            println("reloaded table")
            self.scrollToBottom(true)
        }
        
    }
    
    // SCROLL TO BOTTOm
    
    func scrollToBottom(animated: Bool) {
        
        let delay = 0.1 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            let numberOfSections = self.table_home.numberOfSections()
            let numberOfRows = self.table_home.numberOfRowsInSection(numberOfSections-1)
            
            if numberOfRows > 0 {
                let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
                self.table_home.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
            }
            
        })
    }
    
    // TRANSITION
    
    func didTapCompose(Sender: UIButton!) {
        let composeVC: ComposeViewController = ComposeViewController(nibName: nil, bundle: nil)
        composeVC.delegate = self
        self.definesPresentationContext = true
        composeVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        composeVC.transitioningDelegate = self
        self.presentViewController(composeVC, animated: false) { () -> Void in
            //
        }
    }
    
    // DELEGATE METHOD
    
    func reloadHomeTable(sender:ComposeViewController){
        self.getNotes { () -> Void in
            println("reloaded table")
            self.scrollToBottom(true)
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
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            var query = PFQuery(className:"Note")
            self.noteId = self.notes[indexPath.row].objectId
            query.getObjectInBackgroundWithId(self.noteId) {
                (note: PFObject?, error: NSError?) -> Void in
                if error == nil && note != nil {
                    println(note)
                    
                    note?.deleteInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        if error == nil && success == true {
                            self.notes.removeAtIndex(indexPath.row)
                            self.table_home.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)

                            self.getNotes({ () -> Void in
                                //
                            })
                        }
                        else {
                            println(error)
                        }
                    })
                } else {
                    println(error)
                }
            }

            
        }
    }
    
    // TABLE POPULATE CELLS
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var note = self.notes[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.label_text.text = note["text"] as! String!
        cell.backgroundColor = UIColor.clearColor()
        
        tableHeight = self.table_home.contentSize.height
        
        cell.sizeToFit()
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    

    // MISC
    // ------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames()
        for familyName in fontFamilyNames {
            println("------------------------------")
            println("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNamesForFamilyName(familyName as! String)
            println("Font Names = [\(names)]")
        }
    }

}
