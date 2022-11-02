//
//  UpdateImageModel.swift
//  Gifts
//
//  Created by Apple on 15/06/22.
//

import Foundation


struct UpdateImageModel : Codable {
    let success : Bool?
    let data : UpdateImageData?
    let message : String?
    let status : Int?

}
struct UpdateImageData : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let description : String?
    let created_at : String?
    let updated_at : String?
    let deleted_at : String?
    let lat : String?
    let lng : String?
    let giftimages : [Giftimages]?
}
