//
//  ShowPersonPresenter.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 29/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

protocol ShowPersonPresenterOutput {
    
}

class ShowPersonPresenter: ShowPersonInteractorOutput, ShowPersonViewOutput {
    
    var presenterOutput: ShowPersonPresenterOutput?
    var viewInput: ShowPersonViewInput?
    
}
