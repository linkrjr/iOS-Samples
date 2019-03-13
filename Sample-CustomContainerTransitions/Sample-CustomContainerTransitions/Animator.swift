//
//  Animator.swift
//  Sample-CustomContainerTransitions
//
//  Created by Ronaldo GomesJr on 2/11/2015.
//  Copyright © 2015 TechnophileIT. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        transitionContext.containerView()?.addSubview((toViewController?.view)!)
        toViewController?.view.alpha = 0
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            
            fromViewController?.view.transform = CGAffineTransformMakeScale(0.1, 0.1)
            toViewController?.view.alpha = 1
            
        }) { (finished:Bool) -> Void in
            
            fromViewController?.view.transform = CGAffineTransformIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            
        }
        
    }
    
}
