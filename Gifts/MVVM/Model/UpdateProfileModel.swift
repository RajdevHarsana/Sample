//
//  UpdateProfileModel.swift
//  Justruck
//
//  Created by Apple on 09/05/22.
//

import Foundation


struct UpdateProfileModel : Codable {
    let success : Bool?
    let status : Int?
    let data : UpdateProfileData?
    let message : String?

}

struct UpdateProfileData : Codable {
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
    let gift_details : [Giftdetails]?

}
struct User_address : Codable {
    let id : Int?
    let user_id : Int?
    let address1 : String?
    let address2 : String?
    let city : String?
    let state : String?
    let country : String?
    let zip : String?
    let lat : String?
    let lng : String?
    let created_at : String?
    let updated_at : String?
    let geolocation : String?
}

struct Giftdetails : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let created_at : String?
    let updated_at : String?
    let giftimages : [Giftimages]?

}
