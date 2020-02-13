//
//  DetailView.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
    func didTapClose()
}
class DetailView: View {
    weak var delegate: DetailViewDelegate?

    func update(weather: Weather) {
        self.title.text = weather.condition
        self.location.text = weather.name
        self.subTitle.text = weather.conditionDetail
    }
    
    private lazy var close: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var location: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    @objc func closeAction() {
        delegate?.didTapClose()
    }
    
    override func customInit() {
        super.customInit()
        
        backgroundColor = .white
        
        
        let stack = UIStackView(arrangedSubviews: [location, title, subTitle])
        stack.axis = .vertical
        stack.spacing = 4.0
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8.0)
            make.center.equalToSuperview()
            
        }
        
        addSubview(close)
        close.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(22.0)
        }
    }

}
