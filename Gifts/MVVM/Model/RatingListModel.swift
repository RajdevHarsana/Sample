//
//  RatingListModel.swift
//  Justruck
//
//  Created by Apple on 10/05/22.
//

import Foundation


struct RatingListModel : Codable {
    let success : Bool?
    let status : Int?
    let data : [RatingListData]?
    let message : String?
}
struct RatingListData : Codable {
    let id : Int?
    let user_id : Int?
    let review_by : Int?
    let booking_id : Int?
    let rating : String?
    let title : String?
    let review : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let reviewer_detail : Reviewer_detail?
    let user_detail : User_detail?
}
struct Reviewerdetail : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let average_rating : String?
    let review_count : Int?
}
struct User_detail : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let average_rating : String?
    let review_count : Int?
    
}
