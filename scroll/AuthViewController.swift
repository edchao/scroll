//
//  AuthViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/4/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    
    // CLASS VARS
    
    var corner_left: UIImageView!
    var corner_right: UIImageView!
    var corner_bottom_left: UIImageView!
    var corner_bottom_right: UIImageView!
    
    var card : UIView!
    var stroke_card : UIView!
    var stroke_email: UIView!
    var stroke_password : UIView!
    var input_email : UITextField!
    var label_email : UILabel!
    var input_pw : UITextField!
    var label_pw : UILabel!
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
        
        stroke_email = UIView(frame: CGRect(x: 15, y: 50, width: view.frame.width - 15, height: 1))
        stroke_email.backgroundColor = UIColor.strokeColor(alpha: 1.0)
        card.addSubview(stroke_email)
        
        stroke_password = UIView(frame: CGRect(x: 15, y: 100, width: view.frame.width - 15, height: 1))
        stroke_password.backgroundColor = UIColor.strokeColor(alpha: 1.0)
        card.addSubview(stroke_password)
        
        
        // TEXTFIELDS
        
        input_email = UITextField(frame: CGRect(x: 15, y: 6, width: view.frame.width - 20, height: 40))
        input_email.backgroundColor = UIColor.clearColor()
        input_email.textColor = UIColor.primaryColor(alpha: 1)
        input_email.userInteractionEnabled = true
        input_email.font = UIFont.primaryFont()
        input_email.placeholder = "Email"
        card.addSubview(input_email)
        
        input_pw = UITextField(frame: CGRect(x: 15, y: 56, width: view.frame.width - 20, height: 40))
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
        btn_create.addTarget(self, action: "didTapCreate:", forControlEvents: .TouchUpInside)
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
        

    }

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
            self.card.layer.shadowOpacity = 0
            self.card.backgroundColor = UIColor.whiteColor()
            self.card.center.y = self.card_origin_y
            }, completion: nil)
    }
    



}
