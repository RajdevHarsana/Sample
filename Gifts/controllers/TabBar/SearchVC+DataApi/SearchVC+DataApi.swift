//
//  SearchVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 06/06/22.
//

import Foundation
import UIKit




extension SearchVC {
    
    func deleteGift(){
        
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        
        let param:[String:Any] = [
            "gift_id": GiftId ?? 0
        ]
        
        OnboardViewModel.shared.giftDelete(param: param, isAuthorization: true) { [self] (data) in
            self.arrGiver.remove(at: index ?? 0)
        }

    }
    func getAllGifts() {
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
     
        OnboardViewModel.shared.SearchData(param: param, isAuthorization: true) { [self] (data) in
            if UserStoreSingleton.shared.userType == "giver" {
            //   arrGetGift = data.giverObj ?? []
                arrGiver = data.giverObj ?? []
            }else{
                arrGetReceiverGift = data.reciverObj ?? []
            }
            if UserStoreSingleton.shared.userType == "giver" {
                if arrGiver.count == 0 {
                    tblView.isHidden = true
                }else{
                    tblView.isHidden = false
                }

            }else{
                if arrGetReceiverGift.count == 0 {
                    tblView.isHidden = true
                }else{
                    tblView.isHidden = false
                }

            }
         }
     }
}
