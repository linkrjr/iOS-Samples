//
//  Interactor.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 28/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import Foundation

enum Action {
    case willChange
    case didChange
}

struct Event {
    
    var context: AnyObject?
    var action: Action
    
}

protocol EventListener {
    func eventChanged(for event:Event)
}

class Interactor {

    var eventListeners: [EventListener] = []
    
    func addEventListener(_ eventListener: EventListener) {
        self.eventListeners.append(eventListener)
    }
    
    func postEvent(_ event: Event) {
        
        self.eventListeners.forEach { listener in
            listener.eventChanged(for: event)
        }
        
    }
    
}
