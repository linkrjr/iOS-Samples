//
//  PersonDetailProtocols.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

protocol PersonDetailViewProtocol: class {
    
    var presenter: PersonDetailPresenterProtocol? { get set }

    func showPersonDetail(for person: Person)
    
}

protocol PersonDetailWireFrameProtocol: class {
    static func createPersonDetailModule(for person: Person, to segue:UIStoryboardSegue) -> UIViewController
}

protocol PersonDetailPresenterProtocol: class {
    var view: PersonDetailViewProtocol? { get set }
    var wireframe: PersonDetailWireFrameProtocol? { get set }
    var person: Person? { get set }
    
    func viewDidLoad()
}
