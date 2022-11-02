//
//  DetailVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 07/06/22.
//

import Foundation



extension DetailVC {
    
    func deleteGift(){
        
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        
        let param:[String:Any] = [
            "gift_id": GiftId ?? 0
        ]
        
        OnboardViewModel.shared.giftDelete(param: param, isAuthorization: true) { [self] (data) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.navigationController?.popViewController(animated: true)
                
              }
        }

    }
    
    func requestForGift(){
        
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        
        let param:[String:Any] = [
            "gift_id": GiftId ?? 0,
            "giver_id": Giver_Id ?? 0
        ]
        
        OnboardViewModel.shared.RequestGift(param: param, isAuthorization: true) { [self] (data) in
            DisplayBanner.show(message: data.message ?? "")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.popViewController(animated: true)
                
              }
        }

    }
}
