//
//  RegistrationController.swift
//  Tinder
//
//  Created by liroy yarimi on 19/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    fileprivate let selectPhotoButtonHeight: CGFloat = 275
    fileprivate let stackViewSideSpace : CGFloat = 50
    fileprivate let textFieldInsideSpace: CGFloat = 16
    fileprivate let buttonsHeight: CGFloat = 50
    
    //UI Components
    lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Photo", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.heightAnchor.constraint(equalToConstant: selectPhotoButtonHeight).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        button.layer.cornerRadius = buttonsHeight/2
        button.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        return button
    }()
    
    lazy var fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: textFieldInsideSpace, height: buttonsHeight)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        return tf
    }()
    
    lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: textFieldInsideSpace, height: buttonsHeight)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        return tf
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: textFieldInsideSpace, height: buttonsHeight)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        return tf
    }()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        view.backgroundColor = .red
        

        let stackView = UIStackView(arrangedSubviews: [selectPhotoButton, fullNameTextField, emailTextField, passwordTextField, registerButton])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: stackViewSideSpace, bottom: 0, right: stackViewSideSpace))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupGradientLayer(){
        
        let gradientLayer = CAGradientLayer()
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0,1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
}
