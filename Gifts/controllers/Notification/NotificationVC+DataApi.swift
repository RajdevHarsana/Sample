//
//  NotificationVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 06/06/22.
//

import Foundation


extension NotificationVC {
    
    func getNotificationList(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.userBookingNotification(param: param, isAuthorization: true) { [self] (data) in
            arrNotification = data.data ?? [NotificationData]()
            if arrNotification.count == 0 {
                tblView.isHidden = true
            }else{
                tblView.isHidden = false
            }
         
        }
    }
    
  
    
}
