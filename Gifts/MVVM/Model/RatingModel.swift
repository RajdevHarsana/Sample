//
//  RatingModel.swift
//  Justruck
//
//  Created by Apple on 06/05/22.
//

import Foundation



struct RatingModel : Codable {
    let success : Bool?
    let status : Int?
    let data : RatingData?
    let message : String?
    
}

struct RatingData : Codable {
    let booking_id : Int?
    let user_id : Int?
    let review_by : Int?
    let rating : Double?
    let title : String?
    let review : String?
    let updated_at : String?
    let created_at : String?
    let id : Int?
}
