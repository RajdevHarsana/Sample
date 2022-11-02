//
//  SignUpModel.swift
//  Justruck
//
//  Created by Apple on 22/04/22.
//

import Foundation


struct SignUp_data:Codable {
    var userDetail: String?
    var token: String?
}

struct SignUpModel:Codable {
    let success : Bool?
    let status : Int?
    let message : String?
    let expiry_date : String?
    let subscription_type : String?
    let year_expiry_date : String?
    var data : SignUserData?
}

struct SignUserData:Codable {
    let id : Int?
    let access_token : String?
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
    let is_profile_completed : Bool?
   

}
