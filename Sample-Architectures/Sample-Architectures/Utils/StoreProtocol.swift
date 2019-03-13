//
//  Workers.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import Foundation

protocol StoreProtocol {
    
    associatedtype Element
    
    // MARK: CRUD operations - Optional error
    
//    func fetch(completionHandler: (orders: [Element], error: PeopleStoreError?) -> Void)
//    func fetch(id: String, completionHandler: (order: Element?, error: PeopleStoreError?) -> Void)
//    func create(Element: Element, completionHandler: (error: PeopleStoreError?) -> Void)
//    func update(Element: Element, completionHandler: (error: PeopleStoreError?) -> Void)
//    func delete(id: String, completionHandler: (error: PeopleStoreError?) -> Void)
    
    // MARK: CRUD operations - Generic enum result type
    
//    func fetchOrders(completionHandler: PeopleStoreFetchOrdersCompletionHandler)
//    func fetchOrder(id: String, completionHandler: PeopleStoreFetchOrderCompletionHandler)
//    func createOrder(orderToCreate: Element, completionHandler: PeopleStoreCreateOrderCompletionHandler)
//    func updateOrder(orderToUpdate: Element, completionHandler: PeopleStoreUpdateOrderCompletionHandler)
//    func deleteOrder(id: String, completionHandler: PeopleStoreDeleteOrderCompletionHandler)
    
    // MARK: CRUD operations - Inner closure
    
    func fetch(_ completionHandler: ([Element]) -> Void)
//    func fetch(id: String, completionHandler: Element? -> Void)
    func create(_ element: Element, completionHandler: (() -> Void)?) throws -> Void
    func update(_ element: Element, completionHandler: (() -> Void)?) throws -> Void
    func delete(_ element: Element, completionHandler: (() -> Void)?) throws -> Void
}

//typealias PeopleStoreFetchOrdersCompletionHandler = (result: PeopleStoreResult<[Element]>) -> Void
//typealias PeopleStoreFetchOrderCompletionHandler = (result: PeopleStoreResult<Element>) -> Void
//typealias PeopleStoreCreateOrderCompletionHandler = (result: PeopleStoreResult<Void>) -> Void
//typealias PeopleStoreUpdateOrderCompletionHandler = (result: PeopleStoreResult<Void>) -> Void
//typealias PeopleStoreDeleteOrderCompletionHandler = (result: PeopleStoreResult<Void>) -> Void

enum StoreResult<U>
{
    case success(result: U)
    case failure(error: StoreError)
}

// MARK: - Orders store CRUD operation errors
//Equatable
enum StoreError: Error
{
    case cannotFetch(String)
    case cannotCreate(String)
    case cannotUpdate(String)
    case cannotDelete(String)
}

//func ==(lhs: StoreResult<U>, rhs: StoreResult<U>) -> Bool
//{
//    switch (lhs, rhs) {
//    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
//    case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
//    case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
//    case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
//    default: return false
//    }
//}
