//
//  ShowPersonBuilder.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 29/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

class ShowPersonBuilder: Builder {

    override func build() -> Riblet {
        
        let router = ShowPersonRouter()
        
        let interactor = ShowPersonInteractor()
        interactor.router = router

        let presenter = ShowPersonPresenter()
        presenter.presenterOutput = interactor
        interactor.interactorOutput = presenter
        
        let riblet = Riblet(router: router, interactor: interactor, builder: self)
        router.riblet = riblet
        
        if let vc = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "ShowPersonViewController") as? ShowPersonViewController {
            vc.presenter = presenter
            presenter.viewInput = vc
            riblet.viewController = vc
        }
        
        return riblet
    }
    
    override func build(parentInteractor: Interactor) -> Riblet {        
        return self.build()
    }
    
}
