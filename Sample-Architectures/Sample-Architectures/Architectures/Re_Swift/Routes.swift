//
//  Routes.swift
//  Sample-Architectures
//
//  Created by Ronaldo Gomes on 10/8/17.
//  Copyright © 2017 Technophile IT. All rights reserved.
//

import ReSwiftRouter

let mainViewRoute: RouteElementIdentifier = "Main"

let personDetailsRoute: RouteElementIdentifier = "PersonDetails"
let addPersonRoute: RouteElementIdentifier = "AddPerson"

let storyboard = UIStoryboard(name: "main", bundle: nil)

let mainViewControllerIdentifier = "NavigationController"

let listPeopleViewControllerIdentifier = "ListPeopleViewController"
let showPersonViewControllerIdentifier = "ShowPersonViewController"
let addPersonViewControllerIdentifier = "AddPersonViewController"
let addPersonNavigationControllerIdentifier = "AddPersonNavigationController"


//MARK: This is the Routable to control the UINavigationController
class RootRoutable: Routable {

    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func setToMainViewController() -> Routable {
        self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: mainViewControllerIdentifier)
        
        return MainViewRoutable(self.window.rootViewController!)
    }

    func pushRouteSegment(
        _ routeElementIdentifier: RouteElementIdentifier,
        animated: Bool,
        completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == mainViewRoute {
            completionHandler()
            return self.setToMainViewController()
        }
        
        fatalError("Cannot handle this route change!")
    }
    
}

//MARK: This is the Routable to control the ListPeopleViewController
class MainViewRoutable: Routable {
    
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == personDetailsRoute {
            let showPersonViewController = storyboard.instantiateViewController(withIdentifier: showPersonViewControllerIdentifier)
            (self.viewController as! UINavigationController).pushViewController(showPersonViewController, animated: true)
            completionHandler()
            return ShowPersonDetailRoutable()
        } else if routeElementIdentifier == addPersonRoute {
            let addPersonViewController = storyboard.instantiateViewController(withIdentifier: addPersonNavigationControllerIdentifier)
//            let modalNavigationController = UINavigationController(rootViewController: addPersonViewController)
            (self.viewController as! UINavigationController).present(addPersonViewController, animated: true, completion: {
                completionHandler()
            })
            return AddPersonDetailRoutable()
        }
                
        fatalError("Unknown route!!!")
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        return ShowPersonDetailRoutable()
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        completionHandler()
    }
    
}

class ShowPersonDetailRoutable: Routable {}
class AddPersonDetailRoutable: Routable {}
