////
////  LoginModel.swift
////  Gifts
////
////  Created by USER on 13/05/21.
////
//
//import Foundation
////import ObjectMapper
//
//class RegisterModel : Mappable
//{
//      var accessToken : String?
//      var data : RegisterData?
//      var message : String?
//      var status : Int?
//      var success : Bool?
//      var expiry_date : String?
//      var Users : [RegisterData]?
//
//
//    required init?(map: Map) {}
//    
//    func mapping(map: Map) {
//        accessToken <- map["access_token"]
//        data <- map["data"]
//        Users <- map["data"]
//        message <- map["message"]
//        status <- map["status"]
//        success <- map["success"]
//        expiry_date <- map["expiry_date"]
//
//    }
//}
//class RegisterData : Mappable {
//    
//       var address : String?
//       var age : String?
//       var appleId : AnyObject?
//       var city : String?
//       var country : String?
//       var countryCode : String?
//       var createdAt : String?
//       var deletedAt : AnyObject?
//       var deviceToken : String?
//       var deviceType : String?
//       var email : String?
//       var emailVerifiedAt : AnyObject?
//       var facebookId : AnyObject?
//       var firstName : AnyObject?
//       var gender : String?
//       var googleId : AnyObject?
//       var id : Int?
//       var image : String?
//       var instagramId : AnyObject?
//       var lastName : AnyObject?
//       var lat : String?
//       var lng : String?
//       var mobile : String?
//       var name : String?
//       var pincode : String?
//       var state : String?
//       var status : String?
//       var stripeCustomerId : String?
//       var summary : String?
//       var twitterId : AnyObject?
//       var updatedAt : String?
//       var userType : String?
//       var transfers : String?
//       var username : AnyObject?
//       var filters : filters?
//       var parent_id : Int?
//       var assign : [assign]?
//
//
//    required init?(map: Map) {}
//    
//    func mapping(map: Map) {
//        
//        address <- map["address"]
//        age <- map["age"]
//        appleId <- map["apple_id"]
//        city <- map["city"]
//        country <- map["country"]
//        countryCode <- map["country_code"]
//        createdAt <- map["created_at"]
//        deletedAt <- map["deleted_at"]
//        deviceToken <- map["device_token"]
//        deviceType <- map["device_type"]
//        email <- map["email"]
//        emailVerifiedAt <- map["email_verified_at"]
//        facebookId <- map["facebook_id"]
//        firstName <- map["first_name"]
//        gender <- map["gender"]
//        googleId <- map["google_id"]
//        id <- map["id"]
//        image <- map["image"]
//        instagramId <- map["instagram_id"]
//        lastName <- map["last_name"]
//        lat <- map["lat"]
//        lng <- map["lng"]
//        mobile <- map["mobile"]
//        name <- map["name"]
//        pincode <- map["pincode"]
//        state <- map["state"]
//        status <- map["status"]
//        stripeCustomerId <- map["stripe_customer_id"]
//        summary <- map["summary"]
//        twitterId <- map["twitter_id"]
//        updatedAt <- map["updated_at"]
//        userType <- map["user_type"]
//        transfers <- map["transfers"]
//        username <- map["username"]
//        filters <- map["filters"]
//        parent_id <- map["parent_id"]
//        assign <- map["assign"]
//
//    }
//}
//class assign : Mappable {
//    
//    var id : Int?
//    var parent_id : Int?
//    var user_id : Int?
//    var well_id : Int?
//
//    required init?(map: Map) {}
//    
//    func mapping(map: Map) {
//        
//        id <- map["id"]
//        parent_id <- map["parent_id"]
//        user_id <- map["user_id"]
//        well_id <- map["well_id"]
//    }
//}
//
//
