//
//  InspectionModel.swift
//  Justruck
//
//  Created by Apple on 27/04/22.
//

import Foundation


struct InspectionModel : Codable {
    let success : Bool?
    let status : Int?
    let message : String?
    let data : [InspectionData]?
}

struct InspectionData : Codable {
    let id : Int?
    let name : String?
    let address : String?
    let lat : String?
    let lng : String?
    let geolocation : String?
    let openTime : String?
    let closeTime : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case address = "address"
        case lat = "lat"
        case lng = "lng"
        case geolocation = "geolocation"
        case openTime = "open"
        case closeTime = "close"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        geolocation = try values.decodeIfPresent(String.self, forKey: .geolocation)
        openTime = try values.decodeIfPresent(String.self, forKey: .openTime)
        closeTime = try values.decodeIfPresent(String.self, forKey: .closeTime)
    }

}

