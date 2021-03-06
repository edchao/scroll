//
//  ComposeViewController.swift
//  scroll
//
//  Created by Ed Chao on 6/20/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse
import Bolts

protocol ComposeDelegate {
    func reloadHomeTable(sender: ComposeViewController)
}


class ComposeViewController: UIViewController, UITextViewDelegate {
    
    
    // CLASS VARS
    
    var overlay: UIView!
    var card : UIView!
    var stroke_card : UIView!
    var textView_compose : UITextView!
    var label_compose : UILabel!
    var btn_cancel: UIButton!
    var btn_save: UIButton!
    var vIndent: CGFloat! = 110.0
    var hIndent : CGFloat = 30.0
    var card_origin_y : CGFloat! = 300
    var noteText : String! = ""
    var actInd : UIActivityIndicatorView!

    
    // DELEGATE VARS
    
    var delegate: ComposeDelegate?

    
    // PARSE VARIABLES
    var stackObject : PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        
        view.backgroundColor = UIColor.clearColor()
        
        // OVERLAY
        
        overlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        overlay.backgroundColor = UIColor.blackColor()
        overlay.alpha = 0
        view.addSubview(overlay)
        
        
        // CARD
        
        card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 280))
        card_origin_y = view.frame.height + 90
        card.center.y = card_origin_y
        card.backgroundColor = UIColor.whiteColor()
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowOpacity = 0.0
        card.layer.shadowRadius = 10.0
        view.addSubview(card)
        
        // STROKE CARD
        
        stroke_card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        stroke_card.backgroundColor = UIColor.primaryAccent(1.0)
        card.addSubview(stroke_card)
        
        // TEXTFIELD
        
        textView_compose = UITextView(frame: CGRect(x: 15, y: 10, width: view.frame.width - 20, height: 220))
        textView_compose.backgroundColor = UIColor.clearColor()
        textView_compose.textColor = UIColor.primaryColor(1)
        textView_compose.editable = true
        textView_compose.userInteractionEnabled = true
        textView_compose.font = UIFont.primaryFont()
        card.addSubview(textView_compose)
        textView_compose.delegate = self
                
        // LABEL
        label_compose = UILabel(frame: CGRect(x: 20, y: 10, width: view.frame.width, height: 30))
        label_compose.textColor = UIColor.primaryColor(0.5)
        label_compose.font = UIFont.primaryFont()
        label_compose.text = "Write something..."
        label_compose.numberOfLines = 2
        card.addSubview(label_compose)
        
        
        // BUTTONS
        btn_cancel = UIButton(frame: CGRect(x: 20, y: 0, width: 54, height: 30))
        btn_cancel.center.y = card.frame.height - 30
        btn_cancel.backgroundColor = UIColor.neutralColor(0)
        btn_cancel.setTitleColor(UIColor.primaryAccent(1), forState: .Normal)
        btn_cancel.layer.cornerRadius = 4
        btn_cancel.layer.borderWidth = 1
        btn_cancel.layer.borderColor = UIColor.primaryAccent(0).CGColor
        btn_cancel.titleLabel!.font = UIFont.primaryFont()
        btn_cancel.setTitle("Cancel", forState: .Normal)
        btn_cancel.addTarget(self, action: "didTapCancel:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_cancel)
        
        btn_save = UIButton(frame: CGRect(x: view.frame.width - 38 - 20, y: 30, width: 38, height: 30))
        btn_save.center.y = card.frame.height - 30
        btn_save.backgroundColor = UIColor.neutralColor(0)
        btn_save.setTitleColor(UIColor.primaryAccent(1), forState: .Normal)
        btn_save.layer.cornerRadius = 4
        btn_save.layer.borderWidth = 1
        btn_save.layer.borderColor = UIColor.primaryAccent(0).CGColor
        btn_save.titleLabel!.font = UIFont.primaryFont()
        btn_save.setTitle("Save", forState: .Normal)
        btn_save.addTarget(self, action: "didTapSave:", forControlEvents: .TouchUpInside)
        btn_save.alpha = 1.0
        card.addSubview(btn_save)
        
        // ACTIVITY INDICATOR
        actInd = UIActivityIndicatorView()
        actInd.frame = CGRect(x: screenSize.width - 110, y: card.frame.height - 50, width: 40, height: 40)
        actInd.hidesWhenStopped = true
        actInd.color = UIColor.grayColor()
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        card.addSubview(actInd)
        
        
        // KEYBOARD
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        textView_compose.becomeFirstResponder()
        textView_compose.text = noteText
    }
    
    // KEYBOARD BEHAVIOR
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        let kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration = durationValue.doubleValue
        let curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            self.overlay.alpha = 0.06
            self.card.backgroundColor = UIColor.whiteColor()
            self.card.layer.shadowOpacity = 0.3
            self.card.center.y = screenSize.height - kbSize.height - self.card.frame.height/2
            }, completion: nil)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration = durationValue.doubleValue
        let curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            self.overlay.alpha = 0
            self.card.layer.shadowOpacity = 0
            self.card.backgroundColor = UIColor.whiteColor()
            self.card.center.y = self.card_origin_y
            }, completion: nil)
    }
    
    func DismissKeyboard(){
        textView_compose.endEditing(true)
    }

    
    
    // TEXTVIEW BEHAVIOR
    
    
    func textViewDidChange(textView: UITextView) {
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        self.label_compose.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if !textView.hasText() {
            self.label_compose.hidden = false
        }
    }

    
    func disableBtn(){
        self.textView_compose.alpha = 0.3
        self.actInd.startAnimating()
        self.btn_save.alpha = 0.3
        self.btn_save.enabled = false
    }
    
    func enableBtn(){
        self.textView_compose.alpha = 1
        self.actInd.stopAnimating()
        self.btn_save.alpha = 1
        self.btn_save.enabled = true
    }
    
    
    // BUTTON ACTIONS
    
    func didTapCancel(sender:UIButton){
        self.textView_compose.endEditing(true)
        delay(0.5, closure: { () -> () in
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                //
            })
        })

    }

    func didTapSave(sender:UIButton){
        
        self.disableBtn()

        let note = PFObject(className: "Note")
        note.ACL = PFACL(user: PFUser.currentUser()!)
        note["text"] = self.textView_compose.text
        note["user"] = PFUser.currentUser()

        note.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if (success) {
                print("saved issue")
                self.textView_compose.text = ""
                self.textView_compose.endEditing(true)
                self.delegate?.reloadHomeTable(self)
                if self.stackObject != nil {
                    let relation = note.relationForKey("stacks")
                    relation.addObject(self.stackObject)
                    note.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                        self.delegate?.reloadHomeTable(self)
                        print("saved to short stack")
                        self.enableBtn()
                        self.dismissViewControllerAnimated(false, completion: { () -> Void in
                            //
                        })
                    }
                    
                }else{
                    print("there is no shortstack to save this to!")
                    self.dismissViewControllerAnimated(false, completion: { () -> Void in
                        //
                        print("saved to main Stack")
                    })
                }

            } else {
                print(error!.description)
                let alertView = UIAlertView(title: "Something's wrong", message: error!.localizedDescription, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
                self.enableBtn()

            }

        }
        
    }
    
    
    
    
    // DELAY
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }
}
