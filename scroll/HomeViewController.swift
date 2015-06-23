//
//  HomeViewController.swift
//  scroll
//
//  Created by Ed Chao on 6/20/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

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

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    // CLASS VARS
    
    var table_home : UITableView = UITableView()
    var contentContainer : UIView!
    var composeVC: ComposeViewController! = ComposeViewController()
    var tableHeight : CGFloat! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1)
        
        
        // TABLE SETUP
        
        table_home.frame = CGRectMake(0, 20, screenSize.width, screenSize.height-20);
        table_home.rowHeight = 100
        table_home.delegate = self
        table_home.dataSource = self
        table_home.registerClass(HomeTableViewCell.self, forCellReuseIdentifier: "cell")
        table_home.separatorInset = UIEdgeInsetsMake(15, 15, 15, 15)
        table_home.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        table_home.tableHeaderView = nil
        view.addSubview(table_home)
        
        // SETUP CONTAINER
        contentContainer = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        contentContainer.backgroundColor = UIColor.neutralColor(alpha: 0)
        view.addSubview(contentContainer)
        
        // ADD CHILD VC
        self.addChildViewController(self.composeVC)
        self.composeVC.view.frame = self.contentContainer.frame
        self.contentContainer.addSubview(self.composeVC.view)
        
        table_home.tableFooterView = UIView(frame: CGRect.zeroRect)
        self.table_home.rowHeight = UITableViewAutomaticDimension
        

    }
    
    override func viewDidAppear(animated: Bool){
        layoutTextView()
    }
    
    
    // MEMORY HANDLING
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 300))
        footerView.backgroundColor = UIColor.blackColor()
        return footerView
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    // TABLE POPULATE CELLS
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var item = data[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.label_text.text = item as String!
        
        tableHeight = self.table_home.contentSize.height
        
        cell.sizeToFit()
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }

    // RANDOM
    // ------
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}
