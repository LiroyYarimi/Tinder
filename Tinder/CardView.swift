//
//  CardView.swift
//  Tinder
//
//  Created by liroy yarimi on 13/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    
    //configurations
    fileprivate let threshold:CGFloat = 80

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //corner radius
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
        
        //add pan gesture (make the image move as user press it)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    
    
    
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
        var moveTo: CGFloat = 1000 // move right
        
        if x > threshold{
            shouldDismissCard = true
        }else if x < -threshold{
            shouldDismissCard = true
            moveTo = -1000 //move left
        }
 
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard{
                
                self.frame = CGRect(x: moveTo, y: 0, width: self.frame.width, height: self.frame.height)
                
            }else{
                self.transform = .identity
            }
        }) { (_) in
            self.transform = .identity
            self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
