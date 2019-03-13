//
//  PersonDetailWireFrame.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

class PersonDetailWireFrame: PersonDetailWireFrameProtocol {

    @discardableResult
    class func createPersonDetailModule(for person: Person, to segue:UIStoryboardSegue) -> UIViewController {
        if let view = segue.destination as? ShowPersonViewController {
            
            let presenter: PersonDetailPresenterProtocol = PersonDetailPresenter()
            let wireframe: PersonDetailWireFrameProtocol = PersonDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.person = person
            presenter.wireframe = wireframe
        
            return view
        }
        
        return UIViewController()
    }

}
