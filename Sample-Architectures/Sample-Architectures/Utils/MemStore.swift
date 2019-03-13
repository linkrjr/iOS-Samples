//
//  PeopleMemStore.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation

class MemStore<T:Equatable>: StoreProtocol {
    
    typealias Element = T
    
    fileprivate var elements:[Element] = []
    
    convenience init(elements:[Element]) {
        self.init()
        self.elements = elements
    }
    
    func fetch(_ completionHandler: ([Element]) -> Void) {
        
        completionHandler(self.elements)
        
    }
    
    func create(_ person: Element, completionHandler: (() -> Void)? = nil) throws -> Void {
        
        self.elements.append(person)
        completionHandler?()
        
    }
    
    func update(_ element: Element, completionHandler: (() -> Void)? = nil) throws -> Void  {
        
        let index = self.elements.index { (p) -> Bool in
            return p == element
        }
        if let index = index {
            self.elements[index] = element
            completionHandler?()
        } else {
            throw StoreError.cannotUpdate("Cannot update!!!")
        }
    
    }
    
    func delete(_ element: Element, completionHandler: (() -> Void)? = nil) throws -> Void {
        
        let index = self.elements.index { (p) -> Bool in
            return p == element
        }
        if let index = index {
            self.elements.remove(at: index)
            completionHandler?()
        } else {
            throw StoreError.cannotDelete("Cannot delete")
        }
        
    }
    
}
