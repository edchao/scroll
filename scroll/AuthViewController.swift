//
//  AuthViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/4/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse

class AuthViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    
    // CLASS VARS
    
    var logotype: UIImageView!
    var label_punchline: UILabel!
    
    var card : UIView!
    var stroke_card : UIView!
    var stroke_email: UIView!
    var stroke_password : UIView!
    var input_email : UITextField!
    var input_pw : UITextField!
    var btn_go: UIButton!
    var btn_toggle: UIButton!
    

    var card_origin_y : CGFloat! = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        
        
        // LOGOTYPE
        
        logotype = UIImageView(image: UIImage(named: "logotype"))
        logotype.frame = CGRect(x: 0, y: 0, width: 70, height: 27)
        logotype.center.y = screenSize.height * 0.25
        logotype.center.x = view.center.x
        view.addSubview(logotype)

        // label_punchline
        
        label_punchline = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 140))
        label_punchline.text = "One note to remember all the things"
        label_punchline.numberOfLines = 2
        label_punchline.textAlignment = .Center
        label_punchline.font = UIFont.tertiaryFont()
        label_punchline.textColor = UIColor.primaryColor(alpha: 1.0)
        label_punchline.center.y = screenSize.height * 0.4
        label_punchline.center.x = view.center.x
        view.addSubview(label_punchline)
        
        // CARD
        
        card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 160))
        card_origin_y = view.frame.height - 80
        card.center.y = card_origin_y
        card.backgroundColor = UIColor.whiteColor()
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowOpacity = 0.0
        card.layer.shadowRadius = 10.0
        view.addSubview(card)
        
        // STROKES
        
        stroke_card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        stroke_card.backgroundColor = UIColor.primaryAccent(alpha: 1.0)
        card.addSubview(stroke_card)
        
        stroke_email = UIView(frame: CGRect(x: 20, y: 50, width: view.frame.width - 20, height: 1))
        stroke_email.backgroundColor = UIColor.strokeColor(alpha: 1.0)
        card.addSubview(stroke_email)
        
        stroke_password = UIView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 20, height: 1))
        stroke_password.backgroundColor = UIColor.strokeColor(alpha: 1.0)
        card.addSubview(stroke_password)
        
        
        // TEXTFIELDS
        
        input_email = UITextField(frame: CGRect(x: 20, y: 6, width: view.frame.width - 40, height: 40))
        input_email.backgroundColor = UIColor.clearColor()
        input_email.textColor = UIColor.primaryColor(alpha: 1)
        input_email.userInteractionEnabled = true
        input_email.font = UIFont.primaryFont()
        input_email.placeholder = "Email"
        card.addSubview(input_email)
        
        input_pw = UITextField(frame: CGRect(x: 20, y: 56, width: view.frame.width - 40, height: 40))
        input_pw.backgroundColor = UIColor.clearColor()
        input_pw.textColor = UIColor.primaryColor(alpha: 1)
        input_pw.userInteractionEnabled = true
        input_pw.font = UIFont.primaryFont()
        input_pw.placeholder = "Password"
        card.addSubview(input_pw)

        
        // BUTTONS
        
        btn_toggle = UIButton(frame: CGRect(x: screenSize.width - 100, y: 20, width: 80, height: 30))
        btn_toggle.backgroundColor = UIColor.whiteColor()
        btn_toggle.setTitleColor(UIColor.primaryAccent(alpha: 1.0), forState: .Normal)
        btn_toggle.setTitle("Login", forState: .Normal)
        btn_toggle.setTitle("Sign up", forState: .Selected)
        btn_toggle.addTarget(self, action: "didToggle:", forControlEvents: .TouchUpInside)
        view.addSubview(btn_toggle)
        
        btn_go = UIButton(frame: CGRect(x: 0, y: 30, width: screenSize.width, height: 60))
        btn_go.center.y = card.frame.height - 30
        btn_go.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_go.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_go.layer.cornerRadius = 4
        btn_go.layer.borderWidth = 1
        btn_go.layer.borderColor = UIColor.primaryAccent(alpha: 0).CGColor
        btn_go.titleLabel!.font = UIFont.secondaryFontLarge()
        btn_go.setTitle("Sign up", forState: .Normal)
        btn_go.addTarget(self, action: "didTapGo:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_go)
        
        
        
        // KEYBOARD
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard:"))
        view.addGestureRecognizer(recognizer)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func hideKeyboard(recognizer: UITapGestureRecognizer) {
        input_pw.resignFirstResponder()
        input_email.resignFirstResponder()
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
            
            self.logotype.center.y = screenSize.height * 0.2
            self.label_punchline.center.y = screenSize.height * 0.35
            self.label_punchline.alpha = 0
            
            self.card.backgroundColor = UIColor.whiteColor()
            self.card.layer.shadowOpacity = 0.3
            self.card.center.y = screenSize.height - kbSize.height - self.card.frame.height/2
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
            
            self.logotype.center.y = screenSize.height * 0.25
            self.label_punchline.center.y = screenSize.height * 0.4
            self.label_punchline.alpha = 1
            
            self.card.layer.shadowOpacity = 0
            self.card.backgroundColor = UIColor.whiteColor()
            self.card.center.y = self.card_origin_y
            }, completion: nil)
    }
    

    // TOGGLE
    
    func didToggle(sender:AnyObject){
        if self.btn_toggle.selected {
            self.btn_toggle.selected = false
            self.btn_go.setTitle("Sign up", forState: .Normal)
        }else{
            self.btn_toggle.selected = true
            self.btn_go.setTitle("Log in", forState: .Normal)
        }
        
    }
    
    
    func didTapGo(sender:AnyObject){
        
        
        // LOG IN
        if self.btn_toggle.selected {
            PFUser.logInWithUsernameInBackground(input_email.text.lowercaseString, password:input_pw.text) {
                (user: PFUser?, error: NSError?) -> Void in
                if user != nil {
                    
                    self.input_email.endEditing(true)
                    self.input_pw.endEditing(true)
                    
                    UIView.animateWithDuration(0.5, delay: 0.6, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        self.card.center.y = self.card_origin_y + 110
                        }, completion: { (Bool) -> Void in
                            self.presentModalHome(self)
                    })
                    
                } else {
                    var alertView = UIAlertView(title: "Oops", message: error!.description, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                }
            }

        // SIGN UP
        }else{
            var user = PFUser()
            user.username = self.input_email.text.lowercaseString
            user.password = self.input_pw.text
            
            user.signUpInBackgroundWithBlock { (success, error) -> Void in
                if success {
                    println("successful sign up")
                    
                    self.input_email.endEditing(true)
                    self.input_pw.endEditing(true)
                    
                    UIView.animateWithDuration(0.5, delay: 0.6, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        self.card.center.y = self.card_origin_y + 110
                        }, completion: { (Bool) -> Void in
                            self.delay(0.2, closure: { () -> () in
                                self.presentModalHome(self)
                            })
                    })
                    
                }else{
                    var alertView = UIAlertView(title: "Oops", message: error!.description, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                }
            }
            

        }
        
        

        
    }

    
    
    // PRESENT MODAL HOME
    
    func presentModalHome (sender:AnyObject) {
        let homeVC: HomeViewController = HomeViewController(nibName: nil, bundle: nil)
        let stacksVC: StacksViewController = StacksViewController(nibName:nil, bundle: nil)
        let navVC : NavigationViewController =  NavigationViewController(rootViewController: stacksVC)
        navVC.transitioningDelegate = self
        self.definesPresentationContext = true
        self.presentViewController(navVC, animated: false) { () -> Void in
            navVC.pushViewController(homeVC, animated: false)
        }
    }
    
    // DELAY
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }


}
