//
//  AddressVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 03/06/22.
//

import Foundation
import UIKit



extension AddressVC {
    
    func UploadProfileImageAPI(imageData: Data) {
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.UploadProfileImage(image: imageData, param: param, isAuthorization: true) { [self] (data) in
            DisplayBanner.show(message: data.message)
            uploadImageURL = data.data?.image ?? ""//data.data?.filePath ?? ""
        }
    }
    
    func AddressSignUpAPI() {
      
        if Helper.shared.isFieldEmpty(field: txtfldFirstName.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertFirstName)
            return
        }
        if Helper.shared.isFieldEmpty(field: txtfldLastName.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertLastName)
            return
        }

        if Helper.shared.isFieldEmpty(field: txtfldPhone.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterPhoneNumber)
            return
        }
      
//        if Helper.shared.isFieldEmpty(field: txtfldAddressLine1.text ?? "") {
//            DisplayBanner.show(message: ErrorMessages.alertAddressEmpty)
//            return
//        }
        let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode)
        if countryCode == "" || countryCode == nil {
            DisplayBanner.show(message: ErrorMessages.alertChooseCountryCode)
            return
        }
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let space = txtfldPhone.text?.filter { $0 != Character(" ")} ?? ""
        let hipen = space.filter { $0 != Character("-")}
        let assign = hipen.filter { $0 != Character("(")}
        let assigned = assign.filter { $0 != Character(")")}
        phoneNumber = assigned
        if uploadImageURL != "" {
            let param:[String:Any] = [
                "first_name": txtfldFirstName.text ?? "",
                "last_name" : txtfldLastName.text ?? "",
                "deviceType": deviceType,
                "deviceToken": Global.objGlobalMethod.firebaseToken,
                "city": txtfldCity.text ?? "",
                "state": txtfldState.text ?? "",
                "zip": txtflZipCode.text ?? "",
                "address1": txtfldAddressLine1.text ?? "",
                "country": txtfldCity.text ?? "",
                "image":uploadImageURL,
                "country_code": countryCode!,
                "mobile":phoneNumber,
                "latitude":latitude,
                "longitude":longitude
            ]
            
            OnboardViewModel.shared.updateprofile(param: param, isAuthorization: true) { [self] (data) in
                UserStoreSingleton.shared.userType = data.data?.user_type
             //   UserStoreSingleton.shared.userToken = data.data?.access_token
                UserStoreSingleton.shared.profileImage = data.data?.image
                UserStoreSingleton.shared.name = "\(data.data?.first_name ?? "") \(data.data?.last_name ?? "")"
                UserStoreSingleton.shared.Address = data.data?.user_address?[0].address1
                let objRef:SuccessVC = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
                self.navigationController?.pushViewController(objRef, animated: true)
                
            }
        }else{
            let param:[String:Any] = [
                "first_name": txtfldFirstName.text ?? "",
                "last_name" : txtfldLastName.text ?? "",
                "deviceType": deviceType,
                "deviceToken": Global.objGlobalMethod.firebaseToken,
                "city": txtfldCity.text ?? "",
                "state": txtfldState.text ?? "",
                "zip": txtflZipCode.text ?? "",
                "address1": txtfldAddressLine1.text ?? "",
                "country": txtfldCity.text ?? "",
                "image":"",
                "country_code": countryCode!,
                "mobile":phoneNumber,
                "latitude":latitude,
                "longitude":longitude
            ]
            
            OnboardViewModel.shared.updateprofile(param: param, isAuthorization: true) { [self] (data) in
                UserStoreSingleton.shared.userType = data.data?.user_type
            //    UserStoreSingleton.shared.userToken = data.data?.access_token
                let objRef:SuccessVC = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
                self.navigationController?.pushViewController(objRef, animated: true)
                
            }
        }
    
    }
    
}



