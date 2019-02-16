//
//  HomeController.swift
//  Tinder
//
//  Created by liroy yarimi on 12/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let buttonsStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()
    
    
//    let cardViewModels = ([
//        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
//        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c"),
//        Advertiser(title: "Royal Cruse", brandName: "Your Next Vication", posterPhotoName: "Cruse"),
//        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c")
//
//
//        ] as [producesCardViewModel]).map { (producer) -> CardViewModel in
//            return producer.toCardViewModel()
//    }
    let cardViewModels: [CardViewModel] = {
        let producers = [
            User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
            User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c"),
            Advertiser(title: "Royal Cruse", brandName: "Your Next Vication", posterPhotoName: "Cruse"),
            User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c")
        ] as [producesCardViewModel]
        let viewModels = producers.map({return $0.toCardViewModel()})
        return viewModels
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeScreenView.setupHomeScreenLayout(view: view, topStackView: topStackView, buttonsStackView: buttonsStackView,cardDeckView: cardDeckView)
        
        setupCards()
        
    }

    fileprivate func setupCards(){
        
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.cardViewModel = cardVM
            cardDeckView.addSubview(cardView)
            cardView.fillSuperview()
            
        }
        
        
    }

}

