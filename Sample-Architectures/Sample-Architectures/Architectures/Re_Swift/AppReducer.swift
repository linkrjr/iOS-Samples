//
//  AnyReducer.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func appReducer(action: Action, state: AppState?) -> AppState {
    
    return AppState(people: peopleReducer(action: action, state: state?.people),
                    navigationState: NavigationReducer.handleAction(action, state: state?.navigationState)
    )
    
}

let store = Store<AppState>(
    reducer: appReducer,
    state: nil,
    middleware: []
)
