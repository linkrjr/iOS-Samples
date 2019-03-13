//
//  PersonDetailPresenter.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 1/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

class PersonDetailPresenter: PersonDetailPresenterProtocol {

    var view: PersonDetailViewProtocol?
    var wireframe: PersonDetailWireFrameProtocol?
    var person: Person?
    
    func viewDidLoad() {
        
        self.view?.showPersonDetail(for: self.person!)        
        
    }

}
