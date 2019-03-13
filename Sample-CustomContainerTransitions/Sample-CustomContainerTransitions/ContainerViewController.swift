//
//  ContainerViewController.swift
//  Sample-CustomContainerTransitions
//
//  Created by Ronaldo GomesJr on 2/11/2015.
//  Copyright © 2015 TechnophileIT. All rights reserved.
//

import UIKit

let kbuttonSlotWidth = 64.0
let kbuttonSlotHeight = 44.0

protocol ContainerViewControllerDelegate {
    
    func containerViewControllerDidSelectViewController(containerViewController:ContainerViewController, viewController selectedViewController:UIViewController)
    func containerViewControllerAnimationControllerForTransitionFromViewControllerToViewController(containerViewController:ContainerViewController, fromViewController:UIViewController, toViewController:UIViewController) -> UIViewControllerAnimatedTransitioning
    
}

class ContainerViewController: UIViewController {

    var delegate:ContainerViewControllerDelegate?
    var viewControllers:[UIViewController] = []
    var selectedViewController:UIViewController? {
        willSet {
            self.transitionChildViewController(selectedViewController)
        }
        didSet {
            self.updateButtonSelection()
        }
    }
    
    private var buttonsView:UIView?
    private var containerView:UIView?
    
    convenience init(viewControllers:[UIViewController]) {
        self.init()
        self.viewControllers = viewControllers
    }

    override func loadView() {
        super.loadView()
        
        let rootView = UIView()
        rootView.backgroundColor = UIColor.blackColor()
        rootView.opaque = true
        
        self.containerView = UIView()
        self.containerView?.backgroundColor = UIColor.blackColor()
        self.containerView?.opaque = true
        
        self.buttonsView = UIView()
        self.buttonsView?.backgroundColor = UIColor.clearColor()
        self.buttonsView?.tintColor = UIColor(white: 1, alpha: 0.75)
        
        self.containerView?.translatesAutoresizingMaskIntoConstraints = false
        self.buttonsView?.translatesAutoresizingMaskIntoConstraints = false
        
        rootView.addSubview(self.containerView!)
        rootView.addSubview(self.buttonsView!)
        
        rootView.addConstraint(NSLayoutConstraint(item: self.containerView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0))
        rootView.addConstraint(NSLayoutConstraint(item: self.containerView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0))
        rootView.addConstraint(NSLayoutConstraint(item: self.containerView!, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0))
        rootView.addConstraint(NSLayoutConstraint(item: self.containerView!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))

        rootView.addConstraint(NSLayoutConstraint(item: self.buttonsView!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0))
        rootView.addConstraint(NSLayoutConstraint(item: self.buttonsView!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        rootView.addConstraint(NSLayoutConstraint(item: self.buttonsView!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 0))
        rootView.addConstraint(NSLayoutConstraint(item: self.buttonsView!, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: rootView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        self.addChildViewControllerButtons()
        
        self.view = rootView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedViewController = self.selectedViewController ?? self.viewControllers.first!
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.selectedViewController
    }
    
    private func addChildViewControllerButtons() {
        for (index, _) in EnumerateGenerator(self.buttonsView!.subviews.generate()) {
            
            let button = UIButton(type: .Custom)
            button.tag = index
            
            button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            self.buttonsView?.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let x = 0.5 + Double(index)
            self.buttonsView?.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonsView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: CGFloat(x * kbuttonSlotWidth)))

            self.buttonsView?.addConstraint(NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.buttonsView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0))
            
            
        }
    }
    
    func buttonTapped(sender:UIButton) {
        self.selectedViewController = self.viewControllers[sender.tag]
        
        self.delegate?.containerViewControllerDidSelectViewController(<#T##containerViewController: ContainerViewController##ContainerViewController#>, viewController: <#T##UIViewController#>)
    }
    
    func updateButtonSelection() {
        for (index, button) in EnumerateGenerator(self.buttonsView!.subviews.generate()) {
            (button as! UIButton).selected = (self.viewControllers[index] == self.selectedViewController)
            
        }
    }
    
    func transitionToChildViewController(toViewController:UIViewController) {
        
        var fromViewController:UIViewController? = self.childViewControllers.count > 0 ? self.childViewControllers.first! : nil

        if toViewController == fromViewController || !self.isViewLoaded() {
            return
        }
        
        var toView = toViewController.view
        toView.translatesAutoresizingMaskIntoConstraints = false
        toView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        
        
        
    }
    
}


class PrivateTransitionContext: NSObject, UIViewControllerContextTransitioning {
    
    var viewControllers:[String:UIViewController] = [:]
    var disappearingFromRect:CGRect!
    var appearingFromRect:CGRect!
    var disappearingToRect:CGRect!
    var appearingToRect:CGRect!
    var containerView:UIView!
    var presentationStyle:UIModalPresentationStyle!
    
    var completionBlock:((didComplete:Bool) -> Void)?
    
    convenience init(fromViewController:UIViewController, toViewController:UIViewController, goingRight:Bool) {
        self.init()
        
        self.presentationStyle = .Custom
        self.containerView = fromViewController.view.superview
        self.viewControllers = [
            UITransitionContextFromViewControllerKey:fromViewController,
            UITransitionContextToViewControllerKey:toViewController
        ]
        
        let travelDistance = (goingRight ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width)
        self.appearingFromRect = self.containerView.bounds
        self.disappearingFromRect = self.containerView.bounds
        self.disappearingToRect = CGRectOffset(self.containerView.bounds, travelDistance, 0)
        self.appearingToRect    = CGRectOffset(self.containerView.bounds, -travelDistance, 0)
        
    }
 
    func initialFrameForViewController(viewController:ViewController) -> CGRect {
        if viewController == self.viewControllerForKey(UITransitionContextFromViewControllerKey) {
            return self.disappearingFromRect
        } else {
            return self.appearingFromRect
        }
    }
    
    func finalFrameForViewController(viewController:ViewController) -> CGRect {
        if viewController == self.viewControllerForKey(UITransitionContextFromViewControllerKey) {
            return self.disappearingToRect
        } else {
            return self.appearingToRect
        }
    }
    
    func viewControllerForKey(key:String) -> UIViewController? {
        return self.viewControllers[key]!
    }
    
    func completeTransition(didComplete:Bool) {
        if let block = self.completionBlock {
            block(didComplete: didComplete)
        }
    }
    
    
    func transactionWasCancelled() -> Bool {
        return false
    }
    
    func updateInteractiveTransition(percentComplete:CGFloat) {}
    func finishInteractiveTransition() {}
    func cancelInteractiveTransition() {}
    
}


class PrivateAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let kChildViewPadding = 16
    let kDamping = 0.75
    let kInitialSpringVelocity = 0.5
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        let goingRight = transitionContext.initialFrameForViewController(toViewController!).origin.x < transitionContext.finalFrameForViewController(toViewController!).origin.x
        
        let travelDistance = (transitionContext.containerView()?.bounds.size.width)! + CGFloat(kChildViewPadding)
        
        let travel = CGAffineTransformMakeTranslation(goingRight ? travelDistance : -travelDistance, 0)
        
        transitionContext.containerView()?.addSubview(toViewController!.view)
        toViewController!.view.alpha = 0
        toViewController!.view.transform = CGAffineTransformInvert(travel)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: CGFloat(kDamping), initialSpringVelocity: CGFloat(kInitialSpringVelocity), options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                fromViewController?.view.transform = travel
                fromViewController?.view.alpha = 0
                toViewController?.view.transform = CGAffineTransformIdentity
                toViewController?.view.alpha = 1

            }) { (finished:Bool) -> Void in
                fromViewController?.view.transform = CGAffineTransformIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
    
}






