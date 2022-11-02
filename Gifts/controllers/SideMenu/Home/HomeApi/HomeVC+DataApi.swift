//
//  HomeVC+DataApi.swift
//  Gifts
//
//  Created by Apple on 03/06/22.
//

import Foundation
import UIKit

extension HomeVC {
    
    func getGifts() {
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let latitude = defaultValues.value(forKey: "latitude") ?? ""
        let longitude = defaultValues.value(forKey: "longitude") ?? ""
        let param:[String:Any] = ["lat":latitude,
                                  "lng":longitude]
     
        OnboardViewModel.shared.SearchData(param: param, isAuthorization: true) { [self] (data) in
            if UserStoreSingleton.shared.userType == "giver" {
                arrGetGift = data.giverObj ?? []
            }else{
                arrGetReceiverGift = data.reciverObj ?? []
            }
            
          print(arrGetReceiverGift)
           print(arrGetGift )
            if UserStoreSingleton.shared.userType == "giver" {
                if arrGetGift.count == 0 {
                    homeCollection.isHidden = true
                }else{
                    homeCollection.isHidden = false
                }

            }else{
                if arrGetReceiverGift.count == 0 {
                    homeCollection.isHidden = true
                }else{
                    homeCollection.isHidden = false
                }

            }
         }
     }
    
    func getAllGifts(){
        let latitude = defaultValues.value(forKey: "latitude") ?? ""
        let longitude = defaultValues.value(forKey: "longitude") ?? ""
            var request = URLRequest(url: URL(string: "\(BaseViewController.Get_All_Gift)?&lat=\(latitude)&lng=\(longitude)")!,timeoutInterval: Double.infinity)
            
             let token =   UserStoreSingleton.shared.userToken
                print("Access Token --",token ?? "")
           
            request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")

            request.httpMethod = "GET"
     
            print("request",request)
        
            let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
              guard let data = data else {

                return
              }
                do {
                    let responseModel = try JSONDecoder().decode(GetGiftModel.self, from: data)
                    print("responseModel",responseModel)

                    if UserStoreSingleton.shared.userType == "giver" {
                        arrGetGift = responseModel.giverObj ?? []
                    }else{
                        arrGetReceiverGift = responseModel.reciverObj ?? []
                    }
                  print(arrGetReceiverGift)
                   print(arrGetGift )
                    if UserStoreSingleton.shared.userType == "giver" {
                        if arrGetGift.count == 0 {
                            DispatchQueue.main.async {
                                self.homeCollection.isHidden = true
                            }
                        }else{
                            DispatchQueue.main.async {
                                self.homeCollection.isHidden = false
                            }
                        }

                    }else{
                        if arrGetReceiverGift.count == 0 {
                            DispatchQueue.main.async {
                                self.homeCollection.isHidden = true
                            }
                          
                        }else{
                            DispatchQueue.main.async {
                                self.homeCollection.isHidden = false
                            }
                           
                        }

                    }

                   } catch {
                           print(error)
                          // completed(.failure(.invalidData))
                     }
            }

            task.resume()
          
        }
}
