//
//  Advertiser.swift
//  Tinder
//
//  Created by liroy yarimi on 16/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

struct Advertiser: producesCardViewModel {
    
    let title: String
    let brandName: String
    let posterPhotoName: String
    
    func toCardViewModel() -> CardViewModel{
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
        attributedText.append(NSMutableAttributedString(string: "\n\(brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        
        return CardViewModel(imageName: posterPhotoName, attributedString: attributedText, textAlignment: .center)

    }
}
