//
//  PeopleListBuilder.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import UIKit

class PeopleListBuilder: Builder {

    var interactor: PeopleListInteractor?
    
    override func build() -> Riblet {
        
        let router = PeopleListRouter()
        
        self.interactor = PeopleListInteractor()
        self.interactor?.router = router
        
        let presenter = PeopleListPresenter()
        presenter.presenterOutput = self.interactor
        self.interactor?.interactorOutput = presenter
        
        let displayRiblet = Riblet(router: router, interactor: self.interactor!, builder: self)
        router.riblet = displayRiblet
        
        if let vc = UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "ListPeopleViewController") as? ListPeopleViewController {
            vc.presenter = presenter
            presenter.viewInput = vc
            displayRiblet.viewController = vc
        }
        
        return displayRiblet
    }

}
