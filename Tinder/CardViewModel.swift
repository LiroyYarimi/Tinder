//
//  CardViewModel.swift
//  Tinder
//
//  Created by liroy yarimi on 15/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

protocol producesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

class CardViewModel {
    
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        
        self.imageNames = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0{
        didSet{
            
            let imageUrl = imageNames[imageIndex]
//            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, imageUrl)
        }
    }
    //Reactive Programing
    var imageIndexObserver: ((Int, String?)->())?
    
    func advanceToNextPhoto(){
        imageIndex = min(imageIndex + 1, imageNames.count - 1)
    }
    func goToPreviousPhoto(){
        imageIndex = max(imageIndex - 1, 0)
    }
}

