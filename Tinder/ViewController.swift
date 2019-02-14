//
//  ViewController.swift
//  Tinder
//
//  Created by liroy yarimi on 12/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let buttonsStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeScreenView.setupHomeScreenLayout(view: view, topStackView: topStackView, buttonsStackView: buttonsStackView,cardDeckView: cardDeckView)
        
        setupCards()
        
    }

    fileprivate func setupCards(){
        
        let cardView = CardView(frame: .zero)
        cardDeckView.addSubview(cardView)
        cardView.fillSuperview()
    }

}

