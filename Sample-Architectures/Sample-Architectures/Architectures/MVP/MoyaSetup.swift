//
//  MoyaSetup.swift
//  Sample-Architectures-MVP
//
//  Created by Ron Gomes on 5/6/18.
//  Copyright © 2018 Technophile IT. All rights reserved.
//

import Foundation
import Moya

enum PeopleTarget: TargetType {
    case list
    case create(Person)
    case delete(Person)
}

extension PeopleTarget {
    var baseURL: URL { return URL(string: "http://localhost:3000")! }
    var path: String {
        switch self {
        case .list, .create: return "/people"
        case .delete(let person): return "/people/\(person.email)"
        }
    }
    
    var task: Task {
        switch self {
        case .list, .delete:
            return .requestPlain
        case .create(let person):
            return .requestParameters(parameters: ["name": person.name, "email": person.email, "age": person.age], encoding: JSONEncoding.default)
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list: return .get
        case .create: return .post
        case .delete: return .delete
        }
    }
    
    var sampleData: Data {
        switch self {
        case .list: return try! JSONEncoder().encode(AppDelegate.people)
        case .create(let person): return try! JSONEncoder().encode(person)
        case .delete(let person): return try! JSONEncoder().encode(person)
        }
    }
    
    var headers: [String : String]? { return nil }
}

let peopleMoyaProvider = MoyaProvider<PeopleTarget>()
