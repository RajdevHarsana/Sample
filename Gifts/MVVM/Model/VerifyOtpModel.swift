//
//  VerifyOtpModel.swift
//  Justruck
//
//  Created by Apple on 22/04/22.
//

import Foundation


struct VerifyOtpModel : Codable {
    let success : Bool?
    let otp : Int?
    let message : String?
    let status : Int?
}
