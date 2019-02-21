//
//  RegistrationController.swift
//  Tinder
//
//  Created by liroy yarimi on 19/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        registrationViewModel.bindableImage.value = image
//        registrationViewModel.image = image
//        self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

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
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.gray, for: .disabled)
        button.isEnabled = false
        
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        button.layer.cornerRadius = buttonsHeight/2
        button.heightAnchor.constraint(equalToConstant: buttonsHeight).isActive = true
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    lazy var fullNameTextField: CustomTextField = {
        let tf = CustomTextField(padding: textFieldInsideSpace, height: buttonsHeight)
        tf.placeholder = "Enter full name"
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var emailTextField: CustomTextField = {
        let tf = CustomTextField(padding: textFieldInsideSpace, height: buttonsHeight)
        tf.placeholder = "Enter email"
        tf.keyboardType = .emailAddress
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let tf = CustomTextField(padding: textFieldInsideSpace, height: buttonsHeight)
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = .white
        tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return tf
    }()
    

    
    @objc fileprivate func handleTextChange(textField: UITextField){
        
        if textField == fullNameTextField{
            registrationViewModel.fullName = textField.text
        }else if textField == emailTextField{
            registrationViewModel.email = textField.text
        }else{
            registrationViewModel.password = textField.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradientLayer()
        setupLayout()
        //keyboard functions
        setupNotificationObservers()
        setupTapGesture()
        
        setupRegistrationViewModelObserver()
    }
    

    
    lazy var verticalStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            passwordTextField,
            registerButton
            ])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 8
        return sv
    }()
    
    lazy var overallStackView = UIStackView(arrangedSubviews: [
        selectPhotoButton,
        verticalStackView
        ])
    
    //change the stack view axis for landscape mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.verticalSizeClass == .compact{
            overallStackView.axis = .horizontal
        }else{
            overallStackView.axis = .vertical
        }
    }
    
    
    let widthPhotoButton: CGFloat = 275
    
    fileprivate func setupLayout() {
        view.addSubview(overallStackView)
        overallStackView.axis = .vertical
        selectPhotoButton.widthAnchor.constraint(equalToConstant: widthPhotoButton).isActive = true
        overallStackView.spacing = 8
        overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: stackViewSideSpace, bottom: 0, right: stackViewSideSpace))
        overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    let gradientLayer = CAGradientLayer()
    
    //fix the gradientLayer frame
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    fileprivate func setupGradientLayer(){
        
        let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0,1]
        view.layer.addSublayer(gradientLayer)
        gradientLayer.frame = view.bounds
    }
    
    //MARK:- Select Photo Functions
    
    @objc fileprivate func handleSelectPhoto(){

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    //MARK:- Register function
    
    @objc fileprivate func handleRegister(){
        
        self.handleTapDismiss()
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err{
                print(err)
                self.showHUDWithError(error: err)
                return
            }
            print("Successfullt registered user: ",res?.user.uid ?? "")
        }
    }
    
    fileprivate func showHUDWithError(error: Error){
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    
    let registrationViewModel = RegistrationViewModel()
    
    fileprivate func setupRegistrationViewModelObserver(){
        
        registrationViewModel.bindableIsFormValid.bind { [unowned self] (isFormValid) in
            guard let isFormValid = isFormValid else {return}
            self.registerButton.isEnabled = isFormValid
            if isFormValid{
                self.registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                self.registerButton.setTitleColor(.white, for: .normal)
            }else{
                self.registerButton.backgroundColor = .lightGray
                self.registerButton.setTitleColor(.gray, for: .normal)
            }
        }
//        registrationViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
//
//            self.registerButton.isEnabled = isFormValid
//            if isFormValid{
//                self.registerButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//                self.registerButton.setTitleColor(.white, for: .normal)
//            }else{
//                self.registerButton.backgroundColor = .lightGray
//                self.registerButton.setTitleColor(.gray, for: .normal)
//            }
//        }
        registrationViewModel.bindableImage.bind { [unowned self] (image) in
            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
//        registrationViewModel.imageObserver = { [unowned self] (image) in
//            self.selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
//        }
        
    }
    
    //MARK:- Keyboard functions
    
    fileprivate func setupTapGesture(){
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
    }
    
    @objc fileprivate func handleTapDismiss(){
        self.view.endEditing(true) //dismiss keyboard
    }
    
    fileprivate func setupNotificationObservers(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc fileprivate func handleKeyboardHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.transform = .identity
        })
    }
    
    
    @objc fileprivate func handleKeyboardShow(notification: Notification){

        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
            else {return}
        let keyboardFrame = value.cgRectValue

        let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
        
        let difference = keyboardFrame.height - bottomSpace
        self.view.transform = CGAffineTransform(translationX: 0, y: -(difference + 8)) //move the view up
    }
    
    //for avoid rotain (we need this for the Observers)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}
