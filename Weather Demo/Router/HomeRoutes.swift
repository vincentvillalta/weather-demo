//
//  HomeRoutes.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import ReSwiftRouter
import SafariServices

extension HomeViewController: Routable {
    func pushRouteSegment(_ viewControllerIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        if viewControllerIdentifier == details {
            let view = DetailViewController()
            present(view, animated: true, completion: completionHandler)
            return view
        }
        fatalError("Cannot handle this route change!")
    }
    
    func popRouteSegment(_ identifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: Routable {
    func pushRouteSegment(_ viewControllerIdentifier: RouteElementIdentifier,
                          animated: Bool,
                          completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        
        fatalError("Cannot handle this route change!")
    }
    
    func popRouteSegment(_ identifier: RouteElementIdentifier,
                         animated: Bool,
                         completionHandler: @escaping RoutingCompletionHandler) {
        self.dismiss(animated: true, completion: nil)
    }
}
