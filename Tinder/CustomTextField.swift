//
//  CustomTextField.swift
//  Tinder
//
//  Created by liroy yarimi on 19/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    let padding: CGFloat
    let height: CGFloat
    
    init(padding: CGFloat, height: CGFloat){
        
        self.padding = padding
        self.height = height
        
        super.init(frame: .zero)
        
        
        layer.cornerRadius = height/2
    }
    
    //16 space from left and right (for the textPlaceHolder from the background)
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    //16 space from left and right (for the text from the background)
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: padding, dy: 0)
    }
    
    //text field height
    override var intrinsicContentSize: CGSize{
        return .init(width: 0, height: height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
