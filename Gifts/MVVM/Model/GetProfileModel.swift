//
//  GetProfileModel.swift
//  Justruck
//
//  Created by Apple on 27/04/22.
//

import Foundation

struct GetProfileModel : Codable {
    let success : Bool?
    let data : GetProfileData?
    let message : String?
    let status : Int?
}

struct GetProfileData : Codable {
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
    let lat : String?
    let lng : String?
    let gift_count : Int?
    let gift_mothly : Int?
    let description : String?
    let device_type : String?
    let device_token : String?
    let status : String?
    let user_type : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let is_info : Bool?
    let geolocation : String?
    let user_address : [User_address]?
    let gift_details :  [Giftdetails]?
}

