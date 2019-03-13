//
//  peopleAPI.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 10/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation
import Alamofire
import ReSwift

// Action Creator
func fetchPeople() -> (AppState, Store<AppState>) -> Action? {
    
    return { state, store in
        AppDelegate.dataStore.fetch({ people in
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                store.dispatch(SetPeople(people: people))
            })
            
        })
        
        return LoadingPeopleAction()
    }
    
}

func remove(person: Person) {
    try! AppDelegate.dataStore.delete(person)
}

func add(person: Person) {
    try! AppDelegate.dataStore.create(person)    
}
