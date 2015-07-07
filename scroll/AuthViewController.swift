//
//  AuthViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/4/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse

class AuthViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    // CLASS VARS
    
    var corner_left: UIImageView!
    var corner_right: UIImageView!
    var corner_bottom_left: UIImageView!
    var corner_bottom_right: UIImageView!
    
    var logotype: UIImageView!
    var label_punchline: UILabel!
    
    var card : UIView!
    var stroke_card : UIView!
    var stroke_email: UIView!
    var stroke_password : UIView!
    var input_email : UITextField!
    var input_pw : UITextField!
    var btn_login: UIButton!
    var btn_create: UIButton!
    
//    var textType : EnumerateSequence! {
//        NameFieldTag = 0,
//    }

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
        btn_login = UIButton(frame: CGRect(x: 20, y: 0, width: 44, height: 30))
        btn_login.center.y = card.frame.height - 30
        btn_login.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_login.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_login.layer.cornerRadius = 4
        btn_login.layer.borderWidth = 1
        btn_login.layer.borderColor = UIColor.primaryAccent(alpha: 0).CGColor
        btn_login.titleLabel!.font = UIFont.primaryFont()
        btn_login.setTitle("Login", forState: .Normal)
        btn_login.addTarget(self, action: "didTapLogin:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_login)
        
        btn_create = UIButton(frame: CGRect(x: view.frame.width - 120 - 20, y: 30, width: 120, height: 30))
        btn_create.center.y = card.frame.height - 30
        btn_create.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_create.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_create.layer.cornerRadius = 4
        btn_create.layer.borderWidth = 1
        btn_create.layer.borderColor = UIColor.primaryAccent(alpha: 0).CGColor
        btn_create.titleLabel!.font = UIFont.primaryFont()
        btn_create.setTitle("Create Account", forState: .Normal)
        btn_create.addTarget(self, action: "didTapSignUp:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_create)
        
        
        // CORNER MASKS
        corner_left = UIImageView(image: UIImage(named: "corner_left"))
        corner_left.frame = CGRect(x: 0, y: 0, width: 6, height: 6)
        view.addSubview(corner_left)
        
        corner_right = UIImageView(image: UIImage(named: "corner_right"))
        corner_right.frame = CGRect(x: screenSize.width - 6, y: 0, width: 6, height: 6)
        view.addSubview(corner_right)
        
        corner_bottom_left = UIImageView(image: UIImage(named: "corner_bottom_left"))
        corner_bottom_left.frame = CGRect(x: 0, y: screenSize.height - 6, width: 6, height: 6)
        view.addSubview(corner_bottom_left)
        
        corner_bottom_right = UIImageView(image: UIImage(named: "corner_bottom_right"))
        corner_bottom_right.frame = CGRect(x: screenSize.width - 6, y: screenSize.height - 6, width: 6, height: 6)
        view.addSubview(corner_bottom_right)
        
        
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
    

    
    // SIGN UP
    
    func didTapSignUp(sender:AnyObject){
        
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
                            let homeVC: HomeViewController = HomeViewController(nibName: nil, bundle: nil)
                            let navVC : UINavigationController =  UINavigationController(rootViewController: homeVC)
                            navVC.navigationBar.barStyle = UIBarStyle.BlackTranslucent
                            self.definesPresentationContext = true
                            homeVC.modalPresentationStyle = UIModalPresentationStyle.Custom
                            homeVC.transitioningDelegate = self
                            self.presentViewController(navVC, animated: false) { () -> Void in
                                //
                            }
                        })
                })
                


                
                


                
            }else{
                var alertView = UIAlertView(title: "Oops", message: error!.description, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
            }
        }


        
    }

    
    
    // SIGN IN AND SIGN UP BUTTON FUNCTIONALITY
    
    func didTapLogin(sender:AnyObject){
        
        PFUser.logInWithUsernameInBackground(input_email.text.lowercaseString, password:input_pw.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
                self.input_email.endEditing(true)
                self.input_pw.endEditing(true)
                
                UIView.animateWithDuration(0.5, delay: 0.6, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                    self.card.center.y = self.card_origin_y + 110
                }, completion: { (Bool) -> Void in
                    let homeVC: HomeViewController = HomeViewController(nibName: nil, bundle: nil)
                    let navVC: UINavigationController = UINavigationController(rootViewController: homeVC)
                    navVC.navigationBar.barStyle = UIBarStyle.BlackTranslucent
                    self.definesPresentationContext = true
                    homeVC.modalPresentationStyle = UIModalPresentationStyle.Custom
                    homeVC.transitioningDelegate = self
                    self.presentViewController(navVC, animated: false) { () -> Void in
                        //
                    }
                })
                


            } else {
                var alertView = UIAlertView(title: "Oops", message: error!.description, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
            }
        }
    }
    
    
    // DELAY
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time( DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
        
        
    }


}
