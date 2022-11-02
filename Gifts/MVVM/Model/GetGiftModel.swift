//
//  GetGiftModel.swift
//  Gifts
//
//  Created by Apple on 09/06/22.
//

import Foundation



struct GetGiftModel : Codable {
    let success : Bool?
    let giverObj : [GiverObj]?
    let reciverObj : [ReciverObj]?
    let message : String?
    let status : Int?

}

struct GiverObj : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let lat : String?
    let lng : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
    let distance : String?
    let giftimages : [Giftimages]?

}

struct ReciverObj : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let lat : String?
    let lng : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
    let distance : String?
    let giftimages : [Giftimages]?

   
}


