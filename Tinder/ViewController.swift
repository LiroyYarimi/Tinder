//
//  ViewController.swift
//  Tinder
//
//  Created by liroy yarimi on 12/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topViewHeight : CGFloat = 150
        let yellowViewHeight : CGFloat = 120
        
        let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
            let v = UIView()
            v.backgroundColor = color
            return v
        }
        let topStackView = UIStackView(arrangedSubviews: subviews) //cmd + control + E = rename varible
        topStackView.distribution = .fillEqually
        topStackView.heightAnchor.constraint(equalToConstant: topViewHeight).isActive = true
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        yellowView.heightAnchor.constraint(equalToConstant: yellowViewHeight).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [topStackView,blueView,yellowView])
        stackView.axis = .vertical
        stackView.frame = .init(x: 0, y: 0, width: 300, height: 200)
        
        view.addSubview(stackView)
        stackView.fillSuperview()
    }


}

