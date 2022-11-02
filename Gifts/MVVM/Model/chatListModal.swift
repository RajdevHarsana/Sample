//
//  chatListModal.swift
//  Gifts
//
//  Created by apple on 16/06/22.
//

import Foundation

struct chatListModal : Codable {
    var success : Bool?
    var data : [chatListData]?
    var message : String?
    var status : Int?
    
}
struct chatListData : Codable {
    
    var created_at : String?
    var id : Int?
    var gift_id : Int?
    var message : String?
    var sent_by : Int?
    var is_seen : String?
    var type : String?
    var file_type : String?
    var last_message : last_message?
    var sent_by_detail : sent_by_detail?
    var receiver_detail : receiver_detail?
    var receiverId : Int?
    var sender_detail : sender_detail?
    var sender_id : Int?
    var updatedAt : String?
    var unseen_message_count : Int?
    var file : String?

}

struct last_message : Codable {

    var chat_id : Int?
    var createdAt : String?
    var file : String?
    var fileExtension : String?
    var fivarype : String?
    var id : Int?
    var isSeen : String?
    var message : String?
    var sent_by : Int?
    var sender_detail : sender_detail?
    var type : String?
    var updatedAt : String?

}
struct sent_by_detail : Codable {

    var id : Int?
    var name : String?
    var first_name : String?
    var last_name : String?
    var email : String?
    var image : String?

}
struct receiver_detail : Codable {

    var id : Int?
    var name : String?
    var first_name : String?
    var last_name : String?
    var email : String?
    var image : String?

}
struct sender_detail : Codable {

    var id : Int?
    var name : String?
    var first_name : String?
    var last_name : String?
    var email : String?
    var image : String?

}
