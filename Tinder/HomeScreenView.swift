//
//  HomeScreenView.swift
//  Tinder
//
//  Created by liroy yarimi on 13/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class HomeScreenView {
    
//    let edgeSpace: CGFloat = 12
    
    static func setupHomeScreenLayout(view: UIView, topStackView: TopNavigationStackView, buttonsStackView: HomeBottomControlsStackView, cardDeckView : UIView){
                
        let overallStackView = UIStackView(arrangedSubviews: [topStackView,cardDeckView,buttonsStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        //edge space
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        //cardDeckView need to be on front of all the views
        overallStackView.bringSubviewToFront(cardDeckView)
    }
    
}
