//
//  Routes.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import ReSwiftRouter
import SafariServices

let homeRoute: RouteElementIdentifier = "Home"
let details: RouteElementIdentifier = "Detail"
class RootRoutable: Routable {

    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func setHomeViewController() -> Routable {
        let homeViewController = HomeViewController()
        self.window.rootViewController = homeViewController
        return self.window.rootViewController as! Routable
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        if to == homeRoute {
            completionHandler()
            return setHomeViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        if routeElementIdentifier == homeRoute {
            completionHandler()
            return setHomeViewController()
        } else {
            fatalError("Route not supported!")
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        // TODO: this should technically never be called -> bug in router
        completionHandler()
    }
}
