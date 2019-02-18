//
//  CardView.swift
//  Tinder
//
//  Created by liroy yarimi on 13/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cardViewModel: CardViewModel!{
        didSet{
            let imageName = cardViewModel.imageNames.first ?? ""
            imageView.image = UIImage(named: imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            //setup bars stack view
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
        }
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let informationLabel = UILabel()
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let barsStackView = UIStackView()
    fileprivate var imageIndex = 0
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    //configurations
    fileprivate let threshold:CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //corner radius
        layer.cornerRadius = 10
        clipsToBounds = true
        
        
        imageViewSetup()
        setupBlackGradientLayer()
        informationLabelSetup()
        setupBarsStackView()
        
        //add pan gesture (make the image move as user press it)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer){
        
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto{
            imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
        }else{
            imageIndex = max(0, imageIndex - 1)
        }
        let imageName = cardViewModel.imageNames[imageIndex]
        imageView.image = UIImage(named: imageName)
        
        barsStackView.arrangedSubviews.forEach { (v) in
            v.backgroundColor = barDeselectedColor
        }
        barsStackView.arrangedSubviews[imageIndex].backgroundColor = .white
    }
    
    fileprivate func setupBarsStackView(){
        
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8),size: .init(width: 0, height: 4))
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually

        
    }
    
    
    fileprivate func setupBlackGradientLayer(){
        
        
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7,1.1]
//        gradientLayer.frame = imageView.frame
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    fileprivate func informationLabelSetup(){
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.textColor = .white
//        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        informationLabel.numberOfLines = 0
    }
    
    fileprivate func imageViewSetup(){
        
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFill
    }
    
    
    //MARK:- Add pan (draging) gesture to card
    
    //add pan gesture function
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        
        
        switch gesture.state {
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)

        case .ended:
            handleEnded(gesture)
        default:
            ()
        }
    }
    
    //move the card around if user hold it
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)
        
        //rotation
        let degrees: CGFloat = translation.x/20  //the degree change follow the user finger
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
        
//        let translation = gesture.translation(in: nil)
//        self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
    }
    
    //return card to is place (or move it away) when user let go
    fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
        
        let x = gesture.translation(in: nil).x
        var shouldDismissCard = false
        var moveTo: CGFloat = 600 // move right
        
        if x > threshold{
            shouldDismissCard = true
        }else if x < -threshold{
            shouldDismissCard = true
            moveTo = -moveTo //move left
        }
 
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard{
                
                self.frame = CGRect(x: moveTo, y: 0, width: self.frame.width, height: self.frame.height)
                
            }else{
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard{
                self.removeFromSuperview()//delete the old card
            }
//            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
