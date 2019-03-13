//
//  ChildViewController.swift
//  Sample-CustomContainerTransitions
//
//  Created by Ronaldo GomesJr on 2/11/2015.
//  Copyright © 2015 TechnophileIT. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {

    var themeColor:UIColor? {
        didSet {
            self.updateAppearance()
        }
    }
    
    override var title:String? {
        didSet {
            super.title = title
            self.updateAppearance()
        }
    }
    
    private var titleLabel:UILabel!

    override func loadView() {
        super.loadView()
        
        self.titleLabel = UILabel()
        self.titleLabel.backgroundColor = UIColor.clearColor()
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.textAlignment = .Center
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view = UIView()
        self.view.addSubview(self.titleLabel)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 0.6, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.title
        self.updateAppearance()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeWithNotification:", name:UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }

    private func updateAppearance() {
        if self.isViewLoaded() {
            self.titleLabel.text = self.title
            self.view.backgroundColor = self.themeColor
            self.view.tintColor = self.themeColor
        }
    }

    private func contentSizeCategoryDidChangeWithNotification(notification:NSNotification) {
        self.titleLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        self.titleLabel.invalidateIntrinsicContentSize()
    }
    
    deinit {
        if self.isViewLoaded() {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
}
