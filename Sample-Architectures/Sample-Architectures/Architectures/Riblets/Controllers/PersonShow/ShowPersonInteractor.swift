//
//  ShowPersonInteractor.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 29/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

protocol ShowPersonInteractorOutput {
    
}

class ShowPersonInteractor: Interactor, ShowPersonPresenterOutput {

    var router: ShowPersonRouter?
    var interactorOutput: ShowPersonInteractorOutput?
    
}
