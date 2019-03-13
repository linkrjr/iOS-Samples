//
//  AssetLocator.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 7/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit

class AssetLocator {
    
    class var sharedInstance:AssetLocator {
        struct Singleton {
            static let instace = AssetLocator()
        }
        return Singleton.instace
    }
   
    func getBundledJSON(name:String) -> Dictionary<String, AnyObject>? {
        if let fullPath = Bundle.main.path(forResource: name, ofType: "json") {
            if let databaseData = NSData(contentsOfFile: fullPath) {
                if let JSON = try? JSONSerialization.jsonObject(with: databaseData as Data, options: JSONSerialization.ReadingOptions.mutableLeaves) as? Dictionary<String, AnyObject> {
                    return JSON
                }
            }
        }
        return nil
    }
    
    
}
