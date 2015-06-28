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
    
    var textView_compose : UITextView!
    var label_compose : UILabel!
    var btn_cancel: UIButton!
    var btn_save: UIButton!
    var vIndent: CGFloat! = 110.0
    var hIndent : CGFloat = 30.0
    
    // DELEGATE VARS
    
    var delegate: ComposeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        
        
        // TEXTFIELD
        
        textView_compose = UITextView(frame: CGRect(x: 12, y: 15, width: view.frame.width - 24, height: view.frame.height - 70))
        textView_compose.backgroundColor = UIColor.whiteColor()
        textView_compose.textColor = UIColor.primaryColor(alpha: 1)
        textView_compose.editable = true
        textView_compose.userInteractionEnabled = true
        textView_compose.font = UIFont.primaryFont()
        view.addSubview(textView_compose)
        textView_compose.delegate = self
                
        // LABEL
        label_compose = UILabel(frame: CGRect(x: 15, y: 15, width: view.frame.width, height: 30))
        label_compose.textColor = UIColor.primaryColor(alpha: 0.5)
        label_compose.font = UIFont.primaryFont()
        label_compose.text = "Add your reason..."
        label_compose.numberOfLines = 2
        view.addSubview(label_compose)
        
        
        // BUTTONS
        btn_cancel = UIButton(frame: CGRect(x: 15, y: view.frame.height - 30, width: 70, height: 30))
        btn_cancel.center.y = view.frame.height - 30
        btn_cancel.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_cancel.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_cancel.layer.cornerRadius = 4
        btn_cancel.layer.borderWidth = 1
        btn_cancel.layer.borderColor = UIColor.primaryAccent(alpha: 0.2).CGColor
        btn_cancel.titleLabel!.font = UIFont.primaryFont()
        btn_cancel.setTitle("Cancel", forState: .Normal)
        btn_cancel.addTarget(self, action: "didTapCancel:", forControlEvents: .TouchUpInside)
        view.addSubview(btn_cancel)
        
        btn_save = UIButton(frame: CGRect(x: view.frame.width - 75, y: view.frame.height - 30, width: 60, height: 30))
        btn_save.center.y = self.view.frame.height - 30
        btn_save.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_save.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_save.layer.cornerRadius = 4
        btn_save.layer.borderWidth = 1
        btn_save.layer.borderColor = UIColor.primaryAccent(alpha: 0.2).CGColor
        btn_save.titleLabel!.font = UIFont.primaryFont()
        btn_save.setTitle("Save", forState: .Normal)
        btn_save.addTarget(self, action: "didTapSave:", forControlEvents: .TouchUpInside)
        view.addSubview(btn_save)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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


    
    func DismissKeyboard(){
        textView_compose.endEditing(true)
    }
    
    // BUTTON ACTIONS
    
    func didTapCancel(sender:UIButton){
        self.textView_compose.endEditing(true)
    }

    func didTapSave(sender:UIButton){

        var note = PFObject(className: "Note")
        note["text"] = self.textView_compose.text
        note.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            println("saved issue")
            self.delegate?.reloadHomeTable(self)
            self.textView_compose.endEditing(true)
        }
        
    }
    
}
