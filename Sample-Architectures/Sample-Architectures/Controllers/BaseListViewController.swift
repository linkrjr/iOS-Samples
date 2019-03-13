//
//  BaseListViewController.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/08/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit

private extension Selector {
    
}

class BaseListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItems?.append(self.editButtonItem)
    }

}

extension BaseListViewController {
    
    func prepareAddViewController() -> UIViewController? { return nil }
    
}
