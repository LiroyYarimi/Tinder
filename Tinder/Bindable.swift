//
//  Bindable.swift
//  Tinder
//
//  Created by liroy yarimi on 21/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class Bindable<T> {
    
    var value: T?{
        didSet{
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
