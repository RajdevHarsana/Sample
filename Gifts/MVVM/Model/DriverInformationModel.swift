//
//  DriverInformationModel.swift
//  Justruck
//
//  Created by Apple on 27/04/22.
//

import Foundation


struct DriverInformationModel : Codable {
    let success : Bool?
    let status : Int?
    let data : DriverInformatioData?
    let message : String?
}

struct DriverInformatioData : Codable {
    let id : Int?
    let stripe_customer_id : String?
    let facebook_id : String?
    let google_id : String?
    let apple_id : String?
    let name : String?
    let first_name : String?
    let last_name : String?
    let email : String?
    let email_verified_at : String?
    let country_code : String?
    let mobile : String?
    let otp : String?
    let mobile_verified_at : String?
    let image : String?
    let lat : String?
    let lng : String?
    let geolocation : String?
    let device_type : String?
    let device_token : String?
    let user_type : String?
    let deleted_at : String?
    let created_at : String?
    let updated_at : String?
    let average_rating : String?
    let review_count : Int?
    let document_details : Document_details?

}
struct Document_details : Codable {
    let id : Int?
    let user_id : Int?
    let about : String?
    let vehicle : String?
    let career : String?
    let make : String?
    let model : String?
    let ssn : String?
    let tc : String?
    let license : String?
    let appovement_center : String?
    let policy_no : String?
    let insurrance : String?
    let stage : String?
    let vehicle_image : String?
    let make_id : String?
    let model_id : String?
    let load : String?
    let seat : String?
    let charge : String?
  //  let center : String?
    let make_details : Make_details?
    let model_details : Model_details?
}
struct Center : Codable {
    let id : Int?
    let name : String?
    let address : String?
    let lat : String?
    let lng : String?
    let geolocation : String?
    let open : String?
    let close : String?
}

struct Model_details : Codable {
    let id : Int?
    let title : String?
    let make_id : Int?
}

struct Make_details : Codable {
    let id : Int?
    let title : String?
}

/*
 # Uncomment the next line to define a global platform for your project
 # platform :ios, '9.0'
 target 'Gifts' do
 # Comment the next line if you don't want to use dynamic frameworks
 use_frameworks!
 # Pods for Gifts
 pod 'LGSideMenuController'
 pod 'SkyFloatingLabelTextField', '~> 3.0'
 pod 'Alamofire', '~> 4.7'
 pod 'Toast-Swift', '~> 5.0.1'
 #pod 'ObjectMapper', '~> 3.4'
 pod 'SDWebImage', ' = 5.9.0'
 pod 'IQKeyboardManagerSwift', '6.0.4'
 pod 'NVActivityIndicatorView','4.4.0'
 pod 'SVProgressHUD'
 pod 'FloatRatingView', '~> 4'
 pod 'GoogleSignIn'
 pod "FlagPhoneNumber"
 pod 'Firebase/Messaging'
 #pod 'FirebaseCore'
 #pod 'FirebaseAuth'
 #pod 'FirebaseAnalytics'
 pod 'KeychainSwift'
 pod 'BSImagePicker', '~> 2.8'
 pod 'MultiSlider'
 pod 'Socket.IO-Client-Swift', '~> 15.2.0'
 pod 'Stripe', '~> 8.0'
 pod 'LocationPicker'
 pod 'Charts'
 pod 'GooglePlaces', '= 3.0.3'
 pod 'GooglePlacePicker', '= 3.0.3'
 pod 'GoogleMaps', '= 3.0.3'
 pod "MonthYearPicker", '~> 4.0.2'
 pod 'FacebookCore'
 pod 'FacebookLogin'
 pod 'FacebookShare'
 pod 'Kingfisher'
 pod 'IBAnimatable'
 pod 'MDatePickerView'
 pod 'Designable'
 pod 'IBAnimatable'
 end

 */
