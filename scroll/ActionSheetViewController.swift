//
//  ActionSheetViewController.swift
//  scroll
//
//  Created by Ed Chao on 7/5/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit
import Parse
import Bolts

protocol ActionSheetDelegate {
    func deleteNote(sender: ActionSheetViewController, indexPath: NSIndexPath)
    func editNote(sender: ActionSheetViewController, indexPath: NSIndexPath)
    func presentSelectModal(sender: ActionSheetViewController, indexPath: NSIndexPath)
}


class ActionSheetViewController: UIViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

    // CLASS VARS
    
    var overlay: UIView!
    var card : UIView!
    var stroke_card : UIView!
    var btn_edit: UIButton!
    var btn_shortStack : UIButton!
    var btn_delete: UIButton!
    var btn_cancel: UIButton!
    var card_origin_y : CGFloat! = 300
    
    // PARSE VARS
    var indexPath : NSIndexPath!
    
    // DELEGATE VARS
    
    var delegate: ActionSheetDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clearColor()
        
        // OVERLAY
        
        overlay = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        overlay.backgroundColor = UIColor.blackColor()
        overlay.alpha = 0
        view.addSubview(overlay)
        
        
        // CARD
        
        card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 240))
        card_origin_y = view.frame.height + (card.frame.height / 2)
        card.center.y = card_origin_y
        card.backgroundColor = UIColor.whiteColor()
        card.layer.shadowOffset = CGSize(width: 0, height: 0)
        card.layer.shadowOpacity = 0.0
        card.layer.shadowRadius = 10.0
        view.addSubview(card)
        
        // STROKE CARD
        
        stroke_card = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        stroke_card.backgroundColor = UIColor.primaryAccent(alpha: 1.0)
        card.addSubview(stroke_card)
        
        // BUTTONS
        
        btn_edit = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        btn_edit.setTitle("Edit Note", forState: UIControlState.Normal)
        btn_edit.titleLabel!.font = UIFont.secondaryFontLarge()
        btn_edit.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_edit.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_edit.addTarget(self, action: "didTapEdit:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_edit)
 
        btn_shortStack = UIButton(frame: CGRect(x: 0, y: 60, width: view.frame.width, height: 60))
        btn_shortStack.setTitle("Add to Short Stack", forState: UIControlState.Normal)
        btn_shortStack.titleLabel!.font = UIFont.secondaryFontLarge()
        btn_shortStack.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_shortStack.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_shortStack.addTarget(self, action: "didTapShortStack:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_shortStack)
        
        btn_delete = UIButton(frame: CGRect(x: 0, y: 120, width: view.frame.width, height: 60))
        btn_delete.setTitle("Delete Note", forState: UIControlState.Normal)
        btn_delete.titleLabel!.font = UIFont.secondaryFontLarge()
        btn_delete.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_delete.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_delete.addTarget(self, action: "didTapDelete:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_delete)
        
        btn_cancel = UIButton(frame: CGRect(x: 0, y: 180, width: view.frame.width, height: 60))
        btn_cancel.setTitle("Cancel", forState: UIControlState.Normal)
        btn_cancel.titleLabel!.font = UIFont.secondaryFontLarge()
        btn_cancel.backgroundColor = UIColor.neutralColor(alpha: 0)
        btn_cancel.setTitleColor(UIColor.primaryAccent(alpha: 1), forState: .Normal)
        btn_cancel.addTarget(self, action: "didTapCancel:", forControlEvents: .TouchUpInside)
        card.addSubview(btn_cancel)
        
        
    }

    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.card.layer.shadowOpacity = 0.3
            self.overlay.alpha = 0.06
            self.card.center.y = self.view.frame.height - (self.card.frame.height / 2)
        }) { (Bool) -> Void in
            //
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didTapEdit(sender:UIButton) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.card.layer.shadowOpacity = 0
            self.overlay.alpha = 0
            self.card.center.y = self.card_origin_y
            }) { (Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    delegate?.editNote(self, indexPath: self.indexPath)
                })
        }
    }
    
    
    func didTapShortStack(sender:UIButton) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.card.layer.shadowOpacity = 0
            self.overlay.alpha = 0
            self.card.center.y = self.card_origin_y
            }) { (Bool) -> Void in
                self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    delegate?.presentSelectModal(self, indexPath: self.indexPath)
                })
        }
    }
    

    
    func didTapDelete(sender:UIButton) {
        delegate?.deleteNote(self, indexPath: self.indexPath)
        didTapCancel(self)
    }


    func didTapCancel(sender:AnyObject){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.AllowUserInteraction, animations: { () -> Void in
            self.card.layer.shadowOpacity = 0
            self.overlay.alpha = 0
            self.card.center.y = self.card_origin_y
        }) { (Bool) -> Void in
            self.dismissViewControllerAnimated(false, completion: { () -> Void in
                //
            })
        }

    }


}
