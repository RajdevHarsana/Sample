//
//  BookingModel.swift
//  Justruck
//
//  Created by Apple on 26/04/22.
//

import Foundation

struct BookingModel : Codable {
    let success : Bool?
    let status : Int?
    let data : BookingData?
    let message : String?
}

struct BookingData : Codable {
    let id : Int?
    let user_id : Int?
    let driver_id : Int?
    let booking_date : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let is_rated : Bool?
  
    let details : Details?
    let user : User?
    let driver : Driver?

}

struct Details : Codable {
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
    let userobject : String?
}

struct User : Codable {
    let id : Int?
    let stripe_customer_id : String?
    let facebook_id : String?
    let google_id : String?
    let apple_id : String?
    let name : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let email_verified_at : String?
    let country_code : String?
    let mobile : String?
    let otp : String?
    let mobile_verified_at : String?
    let image : String?
    let lat : String?
    let lng : String?
    let geolocation : String?
    let device_type : String?
    let device_token : String?
    let user_type : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let average_rating : String?
    let review_count : Int?
}

struct Driver : Codable {
    let id : Int?
    let stripe_customer_id : String?
    let facebook_id : String?
    let google_id : String?
    let apple_id : String?
    let name : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let email_verified_at : String?
    let country_code : String?
    let mobile : String?
    let otp : String?
    let mobile_verified_at : String?
    let image : String?
    let lat : String?
    let lng : String?
    let geolocation : String?
    let device_type : String?
    let device_token : String?
    let user_type : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let average_rating : String?
    let review_count : Int?
}
