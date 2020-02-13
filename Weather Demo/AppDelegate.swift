//
//  AppDelegate.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import ReSwiftRouter
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<AppState>!
    var application: UIApplication!
    
    private var store: Store<AppState> {
        return Dependency.shared.store
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize dependencies
        self.application = application
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeViewController()
        
        let rootRoutable = RootRoutable(window: window!)
        router = Router(store: store, rootRoutable: rootRoutable) { state in
            state.select { $0.navigationState }
        }
        
        Dependency.shared.store.dispatch(ReSwiftRouter.SetRouteAction([homeRoute], animated: false))
        //store.dispatch(AppAction.fetchRemoteConfig())
        //Dependency.shared.store.dispatch(ReSwiftRouter.SetRouteAction([launchRoute], animated: false))
        
        window?.makeKeyAndVisible()
        
        return true
    }


}

