//
//  SocialLoginModel.swift
//  Justruck
//
//  Created by Apple on 28/04/22.
//

import Foundation


struct SocialLoginModel : Codable {
    let success : Bool?
    let message : String?
    let is_new_account : Bool?
    let data : SocialLoginData?
    let expiry_date : String?
    let subscription_type : String?
    let year_expiry_date : String?
    let status : Int?
}

struct SocialLoginData : Codable {
    let id : Int?
    let name : String?
    let facebook_id : String?
    let google_id : String?
    let apple_id : String?
    let username : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let email_verified_at : String?
    let country_code : String?
    let mobile : String?
    let image : String?
    let is_info : Bool?
    let lat : String?
    let lng : String?
    let device_type : String?
    let device_token : String?
    let status : String?
    let user_type : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let access_token : String?
    let notification : String?
}

