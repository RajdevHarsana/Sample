//
//  SettingVc+DataApi.swift
//  Gifts
//
//  Created by Apple on 10/06/22.
//

import Foundation

extension SettingVC {
    func getBasicDetails(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.GetBasicDetails(param: param, isAuthorization: true) { [self] (data) in
            let rate_on_apple_store = data.data?.rate_on_apple_store
            arrbasicDetails.append(rate_on_apple_store ?? "")
            HelpUs = data.data?.help ?? ""
            rateUsOnApplrStore = rate_on_apple_store ?? ""
            let privacy = data.data?.privacy_policy
            arrbasicDetails.append(privacy ?? "")
            privacypolicy = privacy ?? ""
            
            let terms_conditions = data.data?.terms_conditions
            arrbasicDetails.append(terms_conditions ?? "")
            termsconditions = terms_conditions ?? ""
            tableView.reloadData()
        }
    }
    
}
