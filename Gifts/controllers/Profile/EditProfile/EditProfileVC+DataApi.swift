//
//  EditProfileVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 09/06/22.
//

import Foundation
import SDWebImage
import UIKit

extension EditProfileVC{
    
    func getProfile(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.userGetProfile(param: param, isAuthorization: true) { [self] (data) in
            print(data)
            txtfldFirstName.text = data.data?.first_name
            txtfldLastName.text = data.data?.last_name
            giftDescpt.text = data.data?.description
            let carImg = data.data?.image
            userImg.sd_imageIndicator = SDWebImageActivityIndicator.white
            userImg.sd_setImage(with: URL(string: carImg!), placeholderImage: UIImage(named: ""))
            txtfldPhone.text = data.data?.mobile
            txtfldEmail.text = data.data?.email
            if data.data?.country_code ?? "" == "" {
                btnCountryCode.setTitle("+1", for: .normal)
                btnCountryCode.setTitleColor(UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1), for: .normal)
                txtfldCountryCode.text = "+1"
            }else{
                btnCountryCode.setTitle(data.data?.country_code ?? "", for: .normal)
            }
         
            txtfldPhone.text = format(with: "(XXX) XXX-XXXX", phone: ("\(data.data?.mobile ?? "")"))
            
            if data.data?.user_address?.count == 0 {
                
            }else{
                
            }
        }
    }
    
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
        
      
}
