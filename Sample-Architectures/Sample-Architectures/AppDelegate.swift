//
//  AppDelegate.swift
//  Sample-Architectures
//
//  Created by Ronaldo GomesJr on 4/04/2016.
//  Copyright © 2016 Technophile IT. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

enum Architecture {
    case MVC, MVP, MVVM, PureMVC, Viper, ReSwift, Riblets
    
    init?(name: String) {
        switch name {
        case "MVC": self = .MVC
        case "MVP": self = .MVP
        case "MVVM": self = .MVVM
        case "PureMVC": self = .PureMVC
        case "Viper": self = .Viper
        case "ReSwift": self = .ReSwift
        case "Riblets": self = .Riblets
        default: return nil
        }
    }
    
    var storyboardPath: String { return "main" }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<AppState>!
    
    var appDependency : AppDependencies?
    
    static var architecture: Architecture?
    
    static let people = [
        Person(name: "Ron", email: "ronaldo@frontfoot.com.au", age: 37),
        Person(name: "Gomes", email: "gomes@frontfoot.com.au", age: 30)
    ]

    static let dataStore = MemStore<Person>(elements: AppDelegate.people)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppDelegate.architecture = Architecture(name: ProcessInfo.processInfo.environment["Architecture"]!)
        let storyboard = UIStoryboard(name: "main", bundle: nil)
        let navigationViewController = storyboard.instantiateViewController(withIdentifier: "NavigationController")

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.tintColor = UIColor(red: 29.0/255.0, green: 173.0/255.0, blue: 234.0/255.0, alpha: 1.0)
        self.window!.rootViewController = navigationViewController
        
        switch AppDelegate.architecture! {
        
        case .Viper: self.window!.rootViewController = ListPeopleWireFrame.createListPeople()
        
        case .PureMVC: ApplicationFacade.sharedInstance.startup(app: navigationViewController as! NavigationController)
            
        case .ReSwift:
            window?.rootViewController = UIViewController()
            
            let rootRoutable = RootRoutable(window: window!)
            
            router = Router(store: store, rootRoutable: rootRoutable) { state in
                state.select { $0.navigationState }
            }
            
            store.dispatch( ReSwiftRouter.SetRouteAction([mainViewRoute]) )
            
        case .Riblets:
            self.appDependency = AppDependencies()
            self.appDependency?.configRootView(window: self.window!, forLaunchOptions: launchOptions)
            
        default: self.window!.rootViewController = navigationViewController
        }
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
//        store.dispatch(handleOpenURL(url: url))
        return false
    }

}

