//
//  HomeScreenView.swift
//  Tinder
//
//  Created by liroy yarimi on 13/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class HomeScreenView {
    
    static func setupHomeScreenLayout(view: UIView, topStackView: TopNavigationStackView, buttonsStackView: HomeBottomControlsStackView, blueView : UIView){
        
        blueView.backgroundColor = .blue
        
        let overallStackView = UIStackView(arrangedSubviews: [topStackView,blueView,buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }
    
}
