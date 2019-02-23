//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by liroy yarimi on 20/02/2019.
//  Copyright © 2019 Liroy Yarimi. All rights reserved.
//

import UIKit
import Firebase


class RegistrationViewModel {
    

    var fullName: String?{ didSet{ checkFormValidity() } }
    var email: String?{ didSet{ checkFormValidity() } }
    var password: String?{ didSet{ checkFormValidity() } }
    
    fileprivate func checkFormValidity(){
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    //Reactive proframming
    
    var bindableIsFormValid = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsRegistering = Bindable<Bool>() //show and dismiss registeringHUD

    
    
    
    func performRegistration(completion: @escaping (Error?) -> () ){
        
        guard let email = email, let password = password else {return}
        bindableIsRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err{
                completion(err)
                return
            }
            print("Successfullt registered user: ",res?.user.uid ?? "")
            
            self.saveImageToFirebase(completion: completion)
//            self.saveInfoToFirestore(completion: completion)
        }
    }
    
    fileprivate func saveImageToFirebase(completion: @escaping (Error?) -> () ) {
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/image/\(filename)")
        let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
        ref.putData(imageData, metadata: nil, completion: { (_, err) in
            if let err = err{
                completion(err)
                return
            }
            print("Finish uploading image to storage")
            ref.downloadURL(completion: { (url, err) in
                if let err = err{
                    completion(err)
                    return
                }
                
                self.bindableIsRegistering.value = false
                let imageUrl = url?.absoluteString ?? ""
                print("url: ", imageUrl)
//                completion(nil)
                self.saveInfoToFirestore(imageUrl: imageUrl, completion: completion)
            })
        })
    }
    
    fileprivate func saveInfoToFirestore(imageUrl: String, completion: @escaping (Error?) -> () ){
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        let docData = ["fullName" : fullName ?? "", "uid":uid, "imageUrl1":imageUrl]
        Firestore.firestore().collection("users").document(uid).setData(docData) { (err) in
            if let err = err{
                completion(err)
                return
            }
            print("saveInfoToFirestore")
            completion(nil)
        }
    }
}
