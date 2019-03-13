//
//  ListPeopleWireFrame.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

protocol ListPeopleViewProtocol { }

protocol ListPeopleWireFrameProtocol: class {
    func presentPersonDetailScreen(from view: ListPeopleViewProtocol, for person: Person, to segue: UIStoryboardSegue)
    static func createListPeople() -> UIViewController
}

class ListPeopleWireFrame: ListPeopleWireFrameProtocol {

    func presentPersonDetailScreen(from view: ListPeopleViewProtocol, for person: Person, to segue: UIStoryboardSegue) {}
    static func createListPeople() -> UIViewController { return UIViewController() }
    
}
