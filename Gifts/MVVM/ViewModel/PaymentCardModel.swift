//
//  PaymentCardModel.swift
//  Justruck
//
//  Created by Apple on 26/04/22.
//

import Foundation

class PaymentCardViewModel: NSObject {
    static let shared = PaymentCardViewModel()
//    internal func getCardAPI(param: parameters, isAuthorization: Bool, completion:@escaping (PaymentCardModel) -> Void){
//        NetworkManager.shared.fetch(type: PaymentCardModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .getCard, parameter: param) { (success, result) in
//            Loader.stop()
//              if success{
//                  guard let result = result else {return}
//                  completion(result)
//              }
//        }
//    }
    
    internal func addCardAPI(param: parameters, isAuthorization: Bool, completion:@escaping (PaymentCardDataModel) -> Void){
        NetworkManager.shared.fetch(type: PaymentCardDataModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .saveCard, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }else{
                //  DisplayBanner.show(message: ErrorMessages.inValidCardNumber)
              }
        }
    }
    
    internal func deleteCardAPI(cardId: String, param: parameters, isAuthorization: Bool, completion:@escaping (PaymentCardDataModel) -> Void){
        NetworkManager.shared.fetch(type: PaymentCardDataModel.self, httpMethod: .delete, isAutorization: isAuthorization, api: .deleteCard, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }

    
}
