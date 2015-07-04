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
    var stroke_textField: UIView!
    var textView_email : UITextView!
    var label_email : UILabel!
    var textView_pw : UITextView!
    var label_pw : UILabel!
    var btn_cancel: UIButton!
    var btn_save: UIButton!

    var card_origin_y : CGFloat! = 300

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETUP VIEW
        view.backgroundColor = UIColor.neutralColor(alpha: 1.0)
        
        
        // CARD
        
        card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        card_origin_y = view.frame.height - 100
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
        
        stroke_textField = UIView(frame: CGRect(x: 15, y: 50, width: view.frame.width - 15, height: 1))
        stroke_textField.backgroundColor = UIColor.strokeColor(alpha: 1.0)
        card.addSubview(stroke_textField)
        
        
        // TEXTFIELDS
        
        textView_email = UITextView(frame: CGRect(x: 15, y: 10, width: view.frame.width - 20, height: 220))
        textView_email.backgroundColor = UIColor.clearColor()
        textView_email.textColor = UIColor.primaryColor(alpha: 1)
        textView_email.editable = true
        textView_email.userInteractionEnabled = true
        textView_email.font = UIFont.primaryFont()
        card.addSubview(textView_email)
        
        textView_pw = UITextView(frame: CGRect(x: 15, y: 60, width: view.frame.width - 20, height: 220))
        textView_pw.backgroundColor = UIColor.clearColor()
        textView_pw.textColor = UIColor.primaryColor(alpha: 1)
        textView_pw.editable = true
        textView_pw.userInteractionEnabled = true
        textView_pw.font = UIFont.primaryFont()
        card.addSubview(textView_pw)
        
        // LABELS
        label_email = UILabel(frame: CGRect(x: 20, y: 10, width: view.frame.width, height: 30))
        label_email.textColor = UIColor.primaryColor(alpha: 0.5)
        label_email.font = UIFont.primaryFont()
        label_email.text = "Email"
        label_email.numberOfLines = 2
        card.addSubview(label_email)
        
        label_pw = UILabel(frame: CGRect(x: 20, y: 60, width: view.frame.width, height: 30))
        label_pw.textColor = UIColor.primaryColor(alpha: 0.5)
        label_pw.font = UIFont.primaryFont()
        label_pw.text = "Email"
        label_pw.numberOfLines = 2
        card.addSubview(label_pw)
        
        
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
