//
//  LoginVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 03/06/22.
//

import Foundation
import UIKit


extension loginVC {

    func SignInAPI() {
    
        if Helper.shared.isFieldEmpty(field: email_txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterEmail)
            return
        }
        if Helper.shared.isValidEmailAddress(candidate: email_txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertValidEmail)
            return
        }
        if Helper.shared.isFieldEmpty(field: password_txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterPassword)
            return
        }
        if !Helper.shared.isValidPassword(field: password_txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterValidPassword)
            return
        }
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        
        
        let param:[String:Any] = [
            "email": email_txt.text ?? "",
            "password" : password_txt.text ?? "",
            "device_type": deviceType,
            "device_token": Global.objGlobalMethod.firebaseToken
        ]
        
        OnboardViewModel.shared.userEmailLogin(param: param, isAuthorization: false) { [self] (data) in
         //   passLocation()
            objHudHide()
            UserStoreSingleton.shared.isLoggedIn = true
            UserStoreSingleton.shared.userType = data.data?.user_type
            UserStoreSingleton.shared.userToken = data.data?.access_token
            UserStoreSingleton.shared.is_profile_completed = data.data?.is_profile_completed
            UserStoreSingleton.shared.userID = data.data?.id
            UserStoreSingleton.shared.profileImage = data.data?.image
            UserStoreSingleton.shared.notification = data.data?.notification
            UserStoreSingleton.shared.createdAt = data.data?.created_at
            UserStoreSingleton.shared.expiry_date = data.data?.expiry_date
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UserStoreSingleton.shared.isLoggedIn = true
                UserStoreSingleton.shared.is_Come_FromSocial = false
                APPDELEGATE.configureTabbar()
            }
        }
    }
    
}
