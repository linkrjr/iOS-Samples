//
//  AppState.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import ReSwift
import ReSwiftRouter

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(navigationState: NavigationState())
}

let store = Store<AppState>(
    reducer: appReducer,
    state: nil,
    middleware: []
)
