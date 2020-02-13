//
//  DetailViewController.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftRouter

class DetailViewController: UIViewController {
    
    private let store: Store<AppState>
    private var state: HomeState?
    private lazy var detailView: DetailView = {
        let view = DetailView()
        view.delegate = self
        return view
    }()
    
    init(store: Store<AppState> = Dependency.shared.store) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailView
    }
    
}

extension DetailViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = HomeState
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) { state in
            return state.select({$0.homeState}).skipRepeats()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    
    func newState(state: StoreSubscriberStateType) {
        self.state = state
        let viewModel = HomeViewModel(state)
        if let weather = viewModel.currentWheather {
            detailView.update(weather: weather)
        }
    }
}

extension DetailViewController: DetailViewDelegate {
    func didTapClose() {
                store.dispatch(SetRouteAction(store.state.navigationState.route.dropLast()))

    }
}
