//
//  HomeController.swift
//  Tinder
//
//  Created by liroy yarimi on 12/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController {
    
    let topStackView = TopNavigationStackView()
    let buttonsStackView = HomeBottomControlsStackView()
    let cardDeckView = UIView()
    
    
//    let cardViewModels: [CardViewModel] = {
//        let producers = [
//            User(name: "Kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1","kelly2","kelly3"]),
//            Advertiser(title: "Royal Cruse", brandName: "Your Next Vication", posterPhotoName: "Cruse"),
//            User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1","jane2","jane3"])
//        ] as [producesCardViewModel]
//        let viewModels = producers.map({return $0.toCardViewModel()})
//        return viewModels
//    }()
    
    var cardViewModels = [CardViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topStackView.settingButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        
        HomeScreenView.setupHomeScreenLayout(view: view, topStackView: topStackView, buttonsStackView: buttonsStackView,cardDeckView: cardDeckView)
        
        setupCards()
        fetchUsersFromFirestore()
        
    }
    
    fileprivate func fetchUsersFromFirestore(){
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err{
                print("Failed to fetch users. ",err)
                return
            }
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                self.cardViewModels.append(user.toCardViewModel())
            })
            self.setupCards()
        }
    }
    
    @objc func handleSettings(){
//        print("show setting")
        
        let registrationController = RegistrationController()
        present(registrationController, animated:  true)
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

