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

struct CardViewModel {
    
    let imageName: String
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
}

