//
//  Example3ViewController.swift
//  Sample-RxSwift
//
//  Created by Ronaldo GomesJr on 7/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UIActivityIndicatorView {
    
    /**
     Bindable sink for `startAnimating()`, `stopAnimating()` methods.
     */
    public var rx_animating: AnyObserver<Bool> {
        return UIBindingObserver(UIElement: self) { activityIndicator, active in
            if active {
                self.startAnimating()
            } else {
                self.stopAnimating()
            }
            }.asObserver()
    }
    
}

struct API {
    
    static func usernameAvailability(username:String) -> Observable<Bool> {
//        NSThread.sleepForTimeInterval(60)
        return Observable<Bool>.just(username.characters.count >= 4)
    }
    
    static func signup(username: String, password: String) -> Observable<Bool> {
        // this is also just a mock
        let signupResult = arc4random() % 5 == 0 ? false : true
        return Observable.just(signupResult)
            .concat(Observable.never())
            .throttle(2, scheduler: MainScheduler.instance)
            .take(1)
    }
    
}

enum ValidationResult {
    case OK(message: String)
    case Empty
    case Validating
    case Failed(message: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .OK:
            return true
        default:
            return false
        }
    }
}

extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .OK(message):
            return message
        case .Empty:
            return ""
        case .Validating:
            return "validating ..."
        case let .Failed(message):
            return message
        }
    }
}

struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.redColor()
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .OK:
            return ValidationColors.okColor
        case .Empty:
            return UIColor.blackColor()
        case .Validating:
            return UIColor.blackColor()
        case .Failed:
            return ValidationColors.errorColor
        }
    }
}

struct Validator {

    static func validateUsername(username:String) -> Observable<ValidationResult> {
        return API.usernameAvailability(username).map({ available in
            if available {
                return ValidationResult.OK(message: "Ok")
            } else {
                return ValidationResult.Failed(message: "failed validation!")
            }
        }).startWith(ValidationResult.Validating)
    }

}

extension UILabel {
    var ex_validationResult: AnyObserver<ValidationResult> {
        return UIBindingObserver(UIElement: self) { label, result in
            label.textColor = result.textColor
            label.text = result.description
            }.asObserver()
    }
}

class Example3ViewController: UIViewController {

    var usernameOutlet:UITextField!
    var statusOutlet:UILabel!
    var validateButtonOutlet:UIButton!
    var signingUpOulet: UIActivityIndicatorView!
    var secondControllerButton:UIButton!
    
    private let disposableBag = DisposeBag()
    
    var onDone:(() -> ())?
    
    var flowController:Example3FlowController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.usernameOutlet = UITextField(frame: CGRectZero)
        self.usernameOutlet.borderStyle = UITextBorderStyle.RoundedRect
        self.view.addSubview(self.usernameOutlet)
        
        self.statusOutlet = UILabel()
        self.view.addSubview(self.statusOutlet)

        self.signingUpOulet = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.view.addSubview(self.signingUpOulet)
        
        self.validateButtonOutlet = UIButton(type: .System)
        self.validateButtonOutlet.setTitle("Validate", forState: .Normal)
        self.view.addSubview(self.validateButtonOutlet)
        
        self.secondControllerButton = UIButton(type: .System)
        self.secondControllerButton.setTitle("Second Controller", forState: .Normal)
        self.view.addSubview(self.secondControllerButton)
        
        self.signingUpOulet.hidden = true
        
        let model = Example3ViewModel(input: (
                                        username: self.usernameOutlet.rx_text.asDriver(),
                                        password: Driver.just(""),
                                        loginTaps: self.validateButtonOutlet.rx_tap.asDriver()
                                    ))
        
        model.signupEnabled.driveNext { [weak self] valid in
            self?.validateButtonOutlet.enabled = valid
            self?.validateButtonOutlet.alpha = valid ? 1.0 : 5.0
        }.addDisposableTo(self.disposableBag)
        
        model.signedIn.driveNext { signedIn in
            print("User signed in \(signedIn)")
        }.addDisposableTo(self.disposableBag)
        
        model.signingIn.driveNext { [weak self] signinIn in
            self?.signingUpOulet.hidden = !signinIn
        }.addDisposableTo(self.disposableBag)
        
        self.signingUpOulet.rx_animating
        
        model.signingIn.drive(signingUpOulet.rx_animating)
            .addDisposableTo(self.disposableBag)
        
        model.validatedUsername
            .drive(self.statusOutlet.ex_validationResult)
            .addDisposableTo(self.disposableBag)
        
        self.secondControllerButton.rx_tap.asObservable().subscribeNext { (_) -> Void in
            self.flowController?.showExample3SecondViewController()
            
//            self.onDone?()
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Example3SecondViewController") as! Example3SecondViewController
//            self.navigationController?.pushViewController(vc, animated: true)
            
        }.addDisposableTo(self.disposableBag)
        
        self.applyConstraints()
    }

}

//MARK: Layout Constraints
extension Example3ViewController {
    
    func applyConstraints() {
        
        self.usernameOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: self.usernameOutlet,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 100).active = true
        
        NSLayoutConstraint(
            item: self.usernameOutlet,
            attribute: .CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0).active = true

        NSLayoutConstraint(
            item: self.usernameOutlet,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .NotAnAttribute,
            multiplier: 1.0,
            constant: 200).active = true
        
        
        self.statusOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: self.statusOutlet,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.usernameOutlet,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 15).active = true
        
        NSLayoutConstraint(
            item: self.statusOutlet,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0).active = true
        
        
        self.signingUpOulet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: self.signingUpOulet,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.statusOutlet,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 15).active = true
        
        NSLayoutConstraint(
            item: self.signingUpOulet,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0).active = true
        
        
        self.validateButtonOutlet.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: self.validateButtonOutlet,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.signingUpOulet,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 15).active = true
        
        NSLayoutConstraint(
            item: self.validateButtonOutlet,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0).active = true
        
        self.secondControllerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(
            item: self.secondControllerButton,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.validateButtonOutlet,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 15).active = true
        
        NSLayoutConstraint(
            item: self.secondControllerButton,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0).active = true
        
    }
    
}


