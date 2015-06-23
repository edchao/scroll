//
//  HomeTableViewCell.swift
//  scroll
//
//  Created by Ed Chao on 6/20/15.
//  Copyright (c) 2015 Ed Chao. All rights reserved.
//

import UIKit



class HomeTableViewCell: UITableViewCell, UITextViewDelegate {
    
    var label_text : UILabel! = UILabel()
    var textView_compose : UITextView = UITextView()
    var textView_size : CGSize! = CGSize()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // LABEL
        label_text = UILabel(frame: CGRectMake(30, 30, self.bounds.size.width, 25))
        label_text.textColor = UIColor.primaryColor(alpha: 1)
        label_text.font = UIFont.primaryFont()
        label_text.numberOfLines = 0
        self.contentView.addSubview(label_text)
        
        self.layout()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func layout(){
        
        self.label_text.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        let viewsDictionary = [
            "label_text" :label_text,
        ]
        
        // POSITIONS
        
        let view_constraint_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-15-[label_text]-15-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        
        let view_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[label_text]-20-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        
        self.contentView.addConstraints(view_constraint_H as [AnyObject])
        self.contentView.addConstraints(view_constraint_V as [AnyObject])

        
    }

    
    
}
