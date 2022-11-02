//
//  SignUpVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 03/06/22.
//

import Foundation
import UIKit


extension SignUpVC {
    
    func UploadProfileImageAPI(imageData: Data) {
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.UploadProfileImage(image: imageData, param: param, isAuthorization: true) { [self] (data) in
            DisplayBanner.show(message: data.message)
         //   uploadImageURL = data.data?.image ?? ""//data.data?.filePath ?? ""
        }
    }
    
    func SignUpAPI() {
       
        if Helper.shared.isFieldEmpty(field: emailTxt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEmailEmpty)
            return
        }
        if Helper.shared.isValidEmail(candidate: emailTxt.text ?? ""){
            DisplayBanner.show(message: ErrorMessages.alertValidEmail)
            return
        }
        if Helper.shared.isFieldEmpty(field: passwordTxt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterPassword)
            return
        }
        if !Helper.shared.isValidPassword(field: passwordTxt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterValidPassword)
            return
        }
        if Helper.shared.isFieldEmpty(field: confrimPawdTxt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterConfirmPassword)
            return
        }
        if passwordTxt.text != confrimPawdTxt.text {
            DisplayBanner.show(message: ErrorMessages.alertConfirmPasswordNotMatch)
            return
        }
        
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        
        let param:[String:Any] = [
            
            "email": emailTxt.text ?? "",
            "password":passwordTxt.text ?? "",
            "deviceType": deviceType,
            "deviceToken": Global.objGlobalMethod.firebaseToken,
            
        ]
        OnboardViewModel.shared.userSignUp(param: param, isAuthorization: false) { [self] (data) in
            UserStoreSingleton.shared.userType = data.data?.user_type
            UserStoreSingleton.shared.userToken = data.data?.access_token
            UserStoreSingleton.shared.isLoggedIn = true
            UserStoreSingleton.shared.userID = data.data?.id
            UserStoreSingleton.shared.profileImage = data.data?.image
            UserStoreSingleton.shared.createdAt = data.data?.created_at
            UserStoreSingleton.shared.expiry_date = data.expiry_date
            UserStoreSingleton.shared.subscription_type = data.subscription_type
            UserStoreSingleton.shared.year_expiry_date = data.year_expiry_date
            UserStoreSingleton.shared.is_Come_FromSocial = false
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddressVC") as? AddressVC
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
    
}





