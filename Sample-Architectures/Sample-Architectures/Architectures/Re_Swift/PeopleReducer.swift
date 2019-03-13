//
//  APIReducer.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 10/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import ReSwift
import ReSwiftRouter

func peopleReducer(action: Action, state: PeopleState?) -> PeopleState {
    switch action {
    case let action as SetPeople:
        return .finished(action.people)
    case _ as LoadingPeopleAction:
        return .loading
    case let action as DeletePersonAction:
        remove(person: action.person)
        return .deleted
    case let action as AddPersonAction:
        add(person: action.person)
        return .added        
    default: return state ?? .finished([])
    }
}
