//
//  DriverBookinglistModel.swift
//  Justruck
//
//  Created by Apple on 03/05/22.
//

import Foundation

struct DriverBookinglistModel : Codable {
    let success : Bool?
    let status : Int?
    let data : [DriverBookingData]?
    let message : String?
}

struct DriverBookingData : Codable {
    let id : Int?
    let user_id : Int?
    let driver_id : Int?
    let booking_date : String?
    var status : String?
    let created_at : String?
    let updated_at : String?
    let is_rated : Bool?
    let details : BookingDetails?
    let user : UserBookingDetails?
    let driver : DriverData?
    let booking_review : [Booking_review]?
}

struct BookingDetails : Codable {
    let id : Int?
    let user_id : Int?
    let booking_id : Int?
    let pickup : String?
    let pickup_lat : String?
    let pickup_lng : String?
    let drop : String?
    let drop_lat : String?
    let drop_lng : String?
    let weight : String?
    let dimansional : String?
    let date : String?
    let helper : String?
    let hand_cart : String?
    let other_equipment : String?
    let created_at : String?
    let updated_at : String?
    let object : String?
    let userobject : String?
    
}

struct UserBookingDetails : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let image : String?
    let average_rating : String?
    let review_count : Int?
    let mobile : String?
    
}

struct DriverData : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let image : String?
    let average_rating : String?
    let review_count : Int?
    let mobile : String?
    let document_details : Document_details?
}

