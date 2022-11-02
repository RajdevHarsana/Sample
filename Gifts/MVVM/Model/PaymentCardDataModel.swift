//
//  PaymentCardModel.swift
//  Justruck
//
//  Created by Apple on 26/04/22.
//

import Foundation

struct PaymentCardDataModel : Codable {
    let success : Bool?
    let data : CardDetail?
    let message : String?
    let status : Int?
}

struct CardDetail : Codable {
    let id : Int?
    let user_id : Int?
    let stripe_card_id : String?
    let card_type : String?
    let name_on_card : String?
    let card_number : String?
    let card_last_four : Int?
    let card_expiry_month : String?
    let card_expiry_year : String?
    let card_cvv : String?
    let country : String?
    let is_primary_card : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
}
