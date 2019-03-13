//
//  PeopleReloadAction.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 7/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import ReSwift

struct ShowPersonDetailsAction: Action {
    var person: Person
}

struct LoadingPeopleAction: Action {}

struct SetPeople: Action {
    let people: [Person]
}

struct AddPersonAction: Action {
    let person: Person
}

struct DeletePersonAction: Action {
    let person: Person
}

struct DeletedPersonAction: Action {}
