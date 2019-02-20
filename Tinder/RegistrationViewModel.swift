//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by liroy yarimi on 20/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit


class RegistrationViewModel {
    
    var fullName: String?{ didSet{ checkFormValidity() } }
    var email: String?{ didSet{ checkFormValidity() } }
    var password: String?{ didSet{ checkFormValidity() } }
    
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    //Reactive proframming
    var isFormValidObserver: ((Bool)->())?
    
}
