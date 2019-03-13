//
//  GlobalDatabase.swift
//  Sample-UISearchController
//
//  Created by Ronaldo GomesJr on 7/07/2015.
//  Copyright (c) 2015 Technophile IT. All rights reserved.
//

import UIKit

class GlobalDatabase {
    
    class var sharedInstance:GlobalDatabase {
        struct Singleton {
            static let instance = GlobalDatabase()
        }
        return Singleton.instance
    }
    
    private var _watches = [Watch]()
    var watches: [Watch] {
        get {
            return _watches
        }
    }
    
    func load() {
        var watchesJSON = AssetLocator.sharedInstance.getBundledJSON(name: "watches")!
        var watchesArrayJSON = watchesJSON["watches"]! as? Array<Dictionary<String, AnyObject>>
        for watchJSON:Dictionary<String, AnyObject> in watchesArrayJSON! {
            var watch = Watch(reference: watchJSON["reference"] as! String)
            _watches.append(watch)
        }
    }
}
