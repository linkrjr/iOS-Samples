//
//  Example3SecondViewController.swift
//  Sample-RxSwift
//
//  Created by Ronaldo Gomes on 22/03/2016.
//  Copyright © 2016 it.technophile. All rights reserved.
//

import UIKit

protocol Example3SecondViewControllerDelegate {
    func example3SecondViewControlerDidReceiveTapOnDoneButton(example3SecondViewController:Example3SecondViewController)
}

class Example3SecondViewController: UIViewController {

    var delegate:Example3SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
