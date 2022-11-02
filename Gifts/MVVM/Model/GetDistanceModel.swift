//
//  GetDistanceModel.swift
//  Gifts
//
//  Created by Apple on 16/06/22.
//

import Foundation


struct GetDistanceModel : Codable {
    let success : Bool?
    let data : [Data]?
    let message : String?
    let status : Int?

}
struct GetDistanceData : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
    let lat : String?
    let lng : String?
    let geolocation : String?
    let created_time : String?
    let updated_time : String?
    let distance : String?
    
}
