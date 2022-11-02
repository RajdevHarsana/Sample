//
//  UploadImageModel.swift
//  Justruck
//
//  Created by Apple on 28/04/22.
//

import Foundation


struct UploadImageModel: Codable {
    let success : Bool?
    let status : Int?
    let data : ImageData?
    let message : String?
}
struct ImageData : Codable {
    let images : String?
    let image : String?
    let imageimagekey : String?

}
