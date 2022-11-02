//
//  AddNewGiftModel.swift
//  Gifts
//
//  Created by Apple on 03/06/22.
//

import Foundation

struct AddNewGiftModel : Codable {
    let success : Bool?
    let data : AddNewGiftData?
    let message : String?
    let status : Int?

}
struct  AddNewGiftData : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let created_at : String?
    let updated_at : String?
    let giftimages : [Giftimages]?
}
struct Giftimages : Codable {
    let id : Int?
    let user_id : Int?
    let gift_id : Int?
    let image : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
}
