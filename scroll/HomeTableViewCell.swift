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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = UIColor.neutralColor(1.0)
        
        // LABEL
        label_text = UILabel(frame: CGRectMake(30, 30, self.bounds.size.width, 25))
        label_text.textColor = UIColor.primaryColor(1)
        label_text.font = UIFont.tertiaryFont()
        label_text.numberOfLines = 0
        self.contentView.addSubview(label_text)
        
        
        self.layout()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func layout(){
        
        self.label_text.translatesAutoresizingMaskIntoConstraints = false
        
        
        let viewsDictionary = [
            "label_text" :label_text,
        ]
        
        // POSITIONS
        
        let view_constraint_H:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[label_text]-20-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        
        let view_constraint_V:NSArray = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[label_text]-30-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        
        self.contentView.addConstraints(view_constraint_H as! [NSLayoutConstraint])
        self.contentView.addConstraints(view_constraint_V as! [NSLayoutConstraint])

        
    }

    
    
}
