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
    
    
    // PARSE VARS
    var currentUser = PFUser.currentUser()
    
    
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
    var btn_forgot: UIButton!
    var btn_visibility : UIButton!
    var label_terms: UILabel!
    var btn_terms: UIButton!
    
    
    var kbSizeVal : CGFloat! = 300
    var kbUp : Bool! = false
    var card_origin_y : CGFloat! = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(1.0)
        
        
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
        label_punchline.textColor = UIColor.primaryColor(1.0)
        label_punchline.center.y = screenSize.height * 0.4
        label_punchline.center.x = view.center.x
        view.addSubview(label_punchline)
        
        
        btn_toggle = UIButton(frame: CGRect(x: screenSize.width - 100, y: 30, width: 80, height: 30))
        btn_toggle.backgroundColor = UIColor.clearColor()
        btn_toggle.setTitleColor(UIColor.primaryAccent(1.0), forState: .Normal)
        btn_toggle.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        btn_toggle.setTitle("Login", forState: .Normal)
        btn_toggle.setTitle("Sign up", forState: .Selected)
        btn_toggle.addTarget(self, action: "didToggle:", forControlEvents: .TouchUpInside)
        view.addSubview(btn_toggle)
        
        // CARD
        
        card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 215))
        card_origin_y = view.frame.height - 110
        card.center.y = card_origin_y
        card.backgroundColor = UIColor.whiteColor()
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowOpacity = 0.0
        card.layer.shadowRadius = 10.0
        view.addSubview(card)
        
        // STROKES
        
        stroke_card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        stroke_card.backgroundColor = UIColor.primaryAccent(1.0)
        card.addSubview(stroke_card)
        
        stroke_email = UIView(frame: CGRect(x: 20, y: 50, width: view.frame.width - 20, height: 1))
        stroke_email.backgroundColor = UIColor.strokeColor(1.0)
        card.addSubview(stroke_email)
        
        stroke_password = UIView(frame: CGRect(x: 20, y: 100, width: view.frame.width - 20, height: 1))
        stroke_password.backgroundColor = UIColor.strokeColor(1.0)
        card.addSubview(stroke_password)
        
        
        // TEXTFIELDS
        
        input_email = UITextField(frame: CGRect(x: 20, y: 6, width: view.frame.width - 40, height: 40))
        input_email.backgroundColor = UIColor.clearColor()
        input_email.textColor = UIColor.primaryColor(1)
        input_email.userInteractionEnabled = true
        input_email.font = UIFont.primaryFont()
        input_email.placeholder = "Email"
        input_email.autocapitalizationType = UITextAutocapitalizationType.None
        card.addSubview(input_email)
        
        input_pw = UITextField(frame: CGRect(x: 20, y: 56, width: view.frame.width - 40, height: 40))
        input_pw.backgroundColor = UIColor.clearColor()
        input_pw.textColor = UIColor.primaryColor(1)
        input_pw.userInteractionEnabled = true
        input_pw.font = UIFont.primaryFont()
        input_pw.placeholder = "Password"
        input_pw.secureTextEntry = true
        input_pw.autocapitalizationType = UITextAutocapitalizationType.None
        card.addSubview(input_pw)
        
        
        // label_terms
        
        label_terms = UILabel(frame: CGRect(x: 60, y: 100, width: view.frame.width - 120, height: 50))
        label_terms.text = "By signing up you agree to our"
        label_terms.numberOfLines = 2
        label_terms.textAlignment = .Center
        label_terms.font = UIFont.primaryFontSmall()
        label_terms.textColor = UIColor.primaryColor(0.5)
        card.addSubview(label_terms)

        
        // btn_terms
        
        btn_terms = UIButton(frame: CGRect(x: 60, y: 115, width: view.frame.width - 120, height: 50))
        btn_terms.setTitle("Terms of Service and Privacy Policy", forState: .Normal)
        btn_terms.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        btn_terms.titleLabel?.textAlignment = NSTextAlignment.Center
        btn_terms.titleLabel!.font = UIFont.primaryFontSmall()
        btn_terms.setTitleColor(UIColor.primaryAccent(1.0), forState: .Normal)
        btn_terms.addTarget(self, action: "didTapTerms:", forControlEvents: .TouchUpInside)
        btn_terms.alpha = 1
        card.addSubview(btn_terms)
        
        
        btn_forgot = UIButton(frame: CGRect(x: 60, y: 100, width: view.frame.width - 120, height: 50))
        btn_forgot.setTitle("Did you forget your password?", forState: .Normal)
        btn_forgot.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        btn_forgot.titleLabel?.textAlignment = NSTextAlignment.Center
        btn_forgot.titleLabel!.font = UIFont.primaryFontSmall()
        btn_forgot.backgroundColor = UIColor.clearColor()
        btn_forgot.setTitleColor(UIColor.primaryAccent(1.0), forState: .Normal)
        btn_forgot.addTarget(self, action: "didTapForgot:", forControlEvents: .TouchUpInside)
        btn_forgot.alpha = 0
        card.addSubview(btn_forgot)
        
        
        // BUTTONS
        
 
        
        btn_visibility = UIButton(frame: CGRect(x: screenSize.width - 55, y: 58, width: 52, height: 34))
        btn_visibility.backgroundColor = UIColor.clearColor()
        btn_visibility.setTitleColor(UIColor.primaryAccent(1.0), forState: .Normal)
        btn_visibility.setImage(UIImage(named: "invisible"), forState: .Normal)
        btn_visibility.setImage(UIImage(named: "visible"), forState: .Selected)
        btn_visibility.addTarget(self, action: "didToggleVisibility:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_visibility)
        
        btn_go = UIButton(frame: CGRect(x: 0, y: 30, width: screenSize.width, height: 60))
        btn_go.center.y = card.frame.height - 30
        btn_go.backgroundColor = UIColor.neutralColor(0)
        btn_go.setTitleColor(UIColor.primaryAccent(1), forState: .Normal)
        btn_go.layer.cornerRadius = 4
        btn_go.layer.borderWidth = 1
        btn_go.layer.borderColor = UIColor.primaryAccent(0).CGColor
        btn_go.titleLabel!.font = UIFont.secondaryFontLarge()
        btn_go.setTitle("Sign up", forState: .Normal)
        btn_go.addTarget(self, action: "didTapGo:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_go)
        
        
  
        
        
        
        // KEYBOARD
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard:"))
        view.addGestureRecognizer(recognizer)
        

        // INIT
        if currentUser != nil {
            UIView.animateWithDuration(0.5, delay: 0.6, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.card.center.y = self.card_origin_y + 110
                }, completion: { (Bool) -> Void in
                    self.presentModalHome(self)
            })
        }
        

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
        let kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        let durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration = durationValue.doubleValue
        let curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        let animationCurve = curveValue.integerValue
        kbSizeVal = kbSize.height
        kbUp = true
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            
            self.logotype.center.y = screenSize.height * 0.15
            self.label_punchline.center.y = screenSize.height * 0.3
            self.label_punchline.alpha = 0
            
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
        kbUp = false
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(animationCurve << 16)), animations: {
            
            self.logotype.center.y = screenSize.height * 0.25
            self.label_punchline.center.y = screenSize.height * 0.4
            self.label_punchline.alpha = 1
            
            self.card.layer.shadowOpacity = 0
            self.card.backgroundColor = UIColor.whiteColor()
            self.card.center.y = self.card_origin_y
            }, completion: nil)
    }
    

    // TOGGLE
    
    func toggleAnimation(){
        if self.kbUp == true {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.card.center.y = self.card_origin_y + 160
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        self.card.center.y = screenSize.height - self.kbSizeVal - self.card.frame.height/2
                        }, completion: { (Bool) -> Void in
                            //
                    })
            })

        }else{
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                self.card.center.y = self.card_origin_y + 160
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
                        self.card.center.y = self.card_origin_y
                        }, completion: { (Bool) -> Void in
                            //
                    })
            })
        }
        
    }
    
    func didToggleVisibility(sender:UIButton){
        if self.btn_visibility.selected {
            self.btn_visibility.selected = false
            input_pw.secureTextEntry = true
        }else{
            self.btn_visibility.selected = true
            input_pw.font = UIFont.primaryFont()
            input_pw.secureTextEntry = false

        }

    }
    
    func didToggle(sender:AnyObject){
        if self.btn_toggle.selected {
            self.btn_toggle.selected = false
            self.btn_go.setTitle("Sign up", forState: .Normal)
            self.btn_forgot.alpha = 0
            self.btn_terms.alpha = 1
            self.label_terms.alpha = 1
            toggleAnimation()
        }else{
            self.btn_toggle.selected = true
            self.btn_go.setTitle("Log in", forState: .Normal)
            self.btn_forgot.alpha = 1
            self.btn_terms.alpha = 0
            self.label_terms.alpha = 0
            toggleAnimation()
        }
        
    }
    
    func didTapForgot(sender:AnyObject){
        PFUser.requestPasswordResetForEmailInBackground(self.input_email.text!.lowercaseString)
        
        let titlePrompt = UIAlertController(title: "Reset password",
            message: "Enter the email you registered with:",
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Email"
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "Reset", style: .Destructive, handler: { (action) -> Void in
            if let textField = titleTextField {
                self.resetPassword(textField.text!)
            }
        }))
        
        self.presentViewController(titlePrompt, animated: true, completion: nil)
        
    }
    
    func didTapTerms(sender:AnyObject){
        
        let openLink = NSURL(string : "http://thatedchao.com/terms.html")
        UIApplication.sharedApplication().openURL(openLink!)

    }

    
    
    func resetPassword(email : String){
        
        // convert the email string to lower case
        let emailToLowerCase = email.lowercaseString
        // remove any whitespaces before and after the email address
        let emailClean = emailToLowerCase.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        PFUser.requestPasswordResetForEmailInBackground(emailClean) { (success, error) -> Void in
            if (error == nil) {
                let success = UIAlertController(title: "Success", message: "Success! Check your email!", preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                success.addAction(okButton)
                self.presentViewController(success, animated: false, completion: nil)
                
            }else {
                let errormessage = error!.userInfo["error"] as! NSString
                let error = UIAlertController(title: "Cannot complete request", message: errormessage as String, preferredStyle: .Alert)
                let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                error.addAction(okButton)
                self.presentViewController(error, animated: false, completion: nil)
            }
        }
    }
    
    
    func didTapGo(sender:AnyObject){
        
        
        // LOG IN
        if self.btn_toggle.selected {
            PFUser.logInWithUsernameInBackground(input_email.text!.lowercaseString, password:input_pw.text!) {
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
                    let alertView = UIAlertView(title: "Oops", message: error!.description, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                }
            }

        // SIGN UP
        }else{
            let user = PFUser()
            user.username = self.input_email.text!.lowercaseString
            user.password = self.input_pw.text
            
            user.signUpInBackgroundWithBlock { (success, error) -> Void in
                if success {
                    print("successful sign up")
                    
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
                    let alertView = UIAlertView(title: "Oops", message: error!.description, delegate: nil, cancelButtonTitle: "Ok")
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
