//
//  MakeModel.swift
//  Justruck
//
//  Created by Apple on 27/04/22.
//

import Foundation

struct MakeModel : Codable {
    let success : Bool?
    let status : Int?
    let message : String?
    let data : [MakeModelData]?
}

struct MakeModelData : Codable {
    let id : Int?
    let title : String?
    let models : [Models]?
}

struct Models : Codable {
    let id : Int?
    let title : String?
    let make_id : Int?
}
