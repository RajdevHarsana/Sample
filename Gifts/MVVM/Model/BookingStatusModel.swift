//
//  BookingStatusModel.swift
//  Justruck
//
//  Created by Apple on 04/05/22.
//

import Foundation


struct BookingStatusModel : Codable {
    let success : Bool?
    let status : Int?
    let data : BookingStatusData?
    let message : String?
}
struct BookingStatusData : Codable {
    let id : Int?
    let user_id : Int?
    let giver_id : Int?
    let booking_date : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let gift_id : String?
}


struct BookingRequestModel : Codable {
    let success : Bool?
    let status : Int?
    let data : BookingRequestData?
    let message : String?
}

struct  BookingRequestData : Codable {
    let id : Int?
    let user_id : Int?
    let giver_id : Int?
    let booking_date : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let gift_id : String?
}
