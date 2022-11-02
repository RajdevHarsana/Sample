//
//  SearchModel.swift
//  Gifts
//
//  Created by Apple on 06/06/22.
//

import Foundation

struct SearchModel : Codable {
    let success : Bool?
    let giverObj : [GiverObj]?
    let reciverObj : [ReciverObj]?
    let message : String?
    let status : Int?
    }

struct SearchModelData : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let created_at : String?
    let updated_at : String?
    let giftimages : [Giftimages]?

  }


struct DeleteGiftModel : Codable {
    let success : Bool?
    let message : String?
    let status : Int?

}
