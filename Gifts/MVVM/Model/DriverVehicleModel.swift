//
//  DriverVehicleModel.swift
//  Justruck
//
//  Created by Apple on 26/04/22.
//

import Foundation

struct DriverVehicleModel : Codable {
    let success : Bool?
    let status : Int?
    let message : String?
    let data : [VehicleData]?
}

struct VehicleData : Codable {
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
    let is_active : Bool?
    let is_profile_completed : Bool?
    let average_rating : String?
    let review_count : Int?
    let document_details : Document_details?


}
