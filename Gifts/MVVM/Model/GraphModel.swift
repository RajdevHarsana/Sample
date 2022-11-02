//
//  GraphModel.swift
//  Gifts
//
//  Created by Apple on 20/06/22.
//

import Foundation

struct GraphModel : Codable {
    let success : Bool?
    let data : [GraphData]?
    let message : String?
    let status : Int?

}
struct GraphData : Codable {
    let month : String?
    let total : Int?
}
