//
//  BookingHistoryModel.swift
//  Justruck
//
//  Created by Apple on 26/04/22.
//

import Foundation

struct BookingHistoryModel : Codable {
    let success : Bool?
    let status : Int?
    let data : [BookingHistoryData]?
    let message : String?
}

struct BookingHistoryData : Codable {
    let id : Int?
    let user_id : Int?
    let driver_id : Int?
    let booking_date : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let drop_time : String?
    let charge : String?
    let is_rated : Bool?
    let details : BookingDetails?
    let booking_review : [Booking_review]?
    let user : User?
    let driver : Driver?
}


struct Booking_review : Codable {
    let id : Int?
    let user_id : Int?
    let review_by : Int?
    let booking_id : Int?
    let rating : String?
    let title : String?
    let review : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let reviewer_detail : Reviewer_detail?

}
struct Reviewer_detail : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let image : String?
    let average_rating : String?
    let review_count : Int?
}
