//
//  ListPeopleViewModel.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation

class ListPeopleViewModel {
    
    var people:[Person] = [] {
        didSet {
            self.peopleDidChange?(self)
        }
    }
    
    var peopleDidChange:( (ListPeopleViewModel) -> ())?
    
    var count:Int {
        return self.people.count
    }

    required init() {
        self.loadPeople() 
    }
    
//    var nameAndAge:String {
//        let person = self.people![self.currentIndexPath.row]
//        return person.nameAndAge
//    }
    
    func nameAndAgeForIndexPath(_ indexPath:IndexPath) -> String {
        let person = self.fetchPersonByIndexPath(indexPath)
        return "-> \(person.name) (\(person.age))"
    }
    
    func loadPeople() {
        AppDelegate.dataStore.fetch { (people) in
            self.people = people
        }
    }
 
    func fetchPersonByIndexPath(_ indexPath:IndexPath) -> Person {
        return self.people[indexPath.row]
    }
    
    func removePersonAt(IndexPath indexPath: IndexPath) {
        let person = self.people[indexPath.row]
        
        do {
            try AppDelegate.dataStore.delete(person) {
                self.loadPeople()
            }
        }
        catch {}
    }
    
}
