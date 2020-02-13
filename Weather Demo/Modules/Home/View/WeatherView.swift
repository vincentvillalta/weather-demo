//
//  WeatherView.swift
//  Weather Demo
//
//  Created by Vincent Villalta on 2/13/20.
//  Copyright © 2020 vincentvillalta. All rights reserved.
//

import UIKit

class WeatherView: View {
    
    func update(weather: Weather) {
        self.title.text = weather.condition
        self.location.text = weather.name
        self.subTitle.text = weather.conditionDetail
    }
    
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

    override func customInit() {
        super.customInit()
        
        backgroundColor = .white
        
        
        let stack = UIStackView(arrangedSubviews: [location, title, subTitle])
        stack.axis = .vertical
        stack.spacing = 4.0
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().inset(40)
            
        }
    }

}
