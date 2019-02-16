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
            imageView.image = UIImage(named: cardViewModel.imageName)
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
        }
    }
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let informationLabel = UILabel()
    
    
    //configurations
    fileprivate let threshold:CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //corner radius
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageViewSetup()
        informationLabelSetup()

        
        //add pan gesture (make the image move as user press it)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    fileprivate func informationLabelSetup(){
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        informationLabel.text = "Test name test name"
        informationLabel.textColor = .white
        informationLabel.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
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
