//
//  AppState.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import ReSwift
import ReSwiftRouter

struct Response<T>: Equatable {
    var data: T
    
    static func ==(lhs: Response, rhs: Response) -> Bool {
        return true
    }

}

struct AppState: StateType, HasNavigationState {
    var people: PeopleState
    var navigationState: NavigationState
}

enum PeopleState {
    case loading
    case finished([Person])
    case deleted
    case added
}
