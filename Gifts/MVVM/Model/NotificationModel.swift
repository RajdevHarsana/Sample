//
//  NotificationModel.swift
//  Justruck
//
//  Created by Apple on 05/05/22.
//

import Foundation


struct NotificationModel : Codable {
    let success : Bool?
    let data : [NotificationData]?
    let message : String?
    let status : Int?
    
}
struct NotificationData : Codable {
    let id : Int?
    let user_id : Int?
    let giver_id : String?
    let message : String?
    let type : String?
    let data : String?
    let created_at : String?
    let updated_at : String?
    let notification_from : Int?
    let booking_id : Int?
    let status : String?
    let gift_id : Int?
    let receiver_msg : String?
}

