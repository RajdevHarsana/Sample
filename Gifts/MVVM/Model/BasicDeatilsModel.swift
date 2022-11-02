//
//  BasicDeatilsModel.swift
//  Justruck
//
//  Created by Apple on 13/05/22.
//

import Foundation

struct BasicDeatilsModel : Codable {
    let success : Bool?
    let status : Int?
    let data : BasicDeatilsData?
    let message : String?
}

struct BasicDeatilsData : Codable {
    let app_name : String?
    let rate_on_apple_store : String?
    let help : String?
    let rate_on_google_store : String?
    let terms_conditions : String?
    let privacy_policy : String?
    let search_distance_limit : String?
    let instant_slot_notification : String?
}
