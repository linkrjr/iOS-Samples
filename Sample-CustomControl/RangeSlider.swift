//
//  RangeSlider.swift
//  Sample-CustomControl
//
//  Created by Ronaldo GomesJr on 1/12/2015.
//  Copyright © 2015 it.technophile. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {

    var minimumValue = 0.0
    var maximumValue = 1.0
    var lowerValue = 0.2
    var upperValue = 0.8
    
    let trackLayer = RangeSliderTrackLayer()
    let lowerThumbLayer = RangeSliderThumbLayer()
    let upperThumbLayer = RangeSliderThumbLayer()
    
    var previousLocation = CGPoint()
    
    var thumbWidth:CGFloat {
        return CGFloat(bounds.height)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        trackLayer.rangeSlider = self
        trackLayer.contentsScale =  UIScreen.mainScreen().scale
        trackLayer.backgroundColor = UIColor.blueColor().CGColor
        layer.addSublayer(trackLayer)
        
        self.lowerThumbLayer.rangeSlide = self
        lowerThumbLayer.contentsScale =  UIScreen.mainScreen().scale
        lowerThumbLayer.backgroundColor = UIColor.greenColor().CGColor
        layer.addSublayer(lowerThumbLayer)

        self.upperThumbLayer.rangeSlide = self
        upperThumbLayer.contentsScale =  UIScreen.mainScreen().scale
        upperThumbLayer.backgroundColor = UIColor.greenColor().CGColor
        layer.addSublayer(upperThumbLayer)

        
        updateLayerFrames()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        previousLocation = touch.locationInView(self)
        
        if lowerThumbLayer.frame.contains(previousLocation) {
            lowerThumbLayer.highlighted = true
        } else if upperThumbLayer.frame.contains(previousLocation) {
            upperThumbLayer.highlighted = true
        }
        
        return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
    }
    
    func boundValue(value: Double, toLowerValue: Double, upperValue: Double) -> Double {
    
        return min(max(value, lowerValue), upperValue)
    
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        let location = touch.locationInView(self)
        
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbWidth)
        
        previousLocation = location
        
        if lowerThumbLayer.highlighted {
            lowerValue += deltaValue
            lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            upperValue += deltaValue
            upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        sendActionsForControlEvents(.ValueChanged)
        
        return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
    
    func updateLayerFrames() {
        
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()


        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth / 2.0, y: 0.0, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        
    }
    
    func positionForValue(value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) / (maximumValue - minimumValue) + Double(thumbWidth / 2.0)
    }
    
}
