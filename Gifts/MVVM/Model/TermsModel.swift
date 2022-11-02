//
//  TermsModel.swift
//  Gifts
//
//  Created by apple on 23/06/22.
//

import Foundation

struct TermsModel : Codable {
    let success : Bool?
    let data : data?
    let message : String?
    let status : Int?

}
struct data : Codable {
    let terms_conditions : String?
}
