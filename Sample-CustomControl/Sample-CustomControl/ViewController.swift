//
//  ViewController.swift
//  Sample-CustomControl
//
//  Created by Ronaldo GomesJr on 1/12/2015.
//  Copyright © 2015 it.technophile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let rangeSlider = RangeSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rangeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.rangeSlider)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.rangeSlider, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0))

        self.view.addConstraint(NSLayoutConstraint(item: self.rangeSlider, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))

        self.rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        
    }
    
    func rangeSliderValueChanged(sender: RangeSlider) {
        print("range Slider value changed: \(sender.lowerValue) \(sender.upperValue)")
    }
    
    override func viewDidLayoutSubviews() {
        let margin:CGFloat = 20.0
        let width = self.view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length, width: width, height: 31.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

