//
//  EndPoint.swift
//  YoomApplication
//
//  Created by sandeep on 03/01/22.
//

import Foundation

enum EndPoint {
    
    case signUp
    case getProfile
    case sendOtp
    case socialLogin
    case emailLogin
    case getAllGift
    case registerPassword
    case changePassword
    case addGift
    case logOut
    case getDistance
    case getGraph
    case forgotPassword
    case resetPassword
    case uploadFile
    case verifyOtp
    case saveCard
    case deleteCard
    case driverVechile
    case driverReviewList
    case bookingStatus
    case booking
    case bookingHistory
    case deleteAccount
    case notification
    case deleteNotification
    case deleteGift
    case updateProfile
    case updateDriverStatus
    case rating
    case driverBookingList
    case makeVehicle
    case driverInformation
    case inspection
    case basicDetail
    case termsCondition
    case privacypolicy
    case GetUserLists
    case GetChatLists
    case GetTermsConditions
    case updateNotification
    case addpayment

    var path: String {
        switch self {
            //MARK: OnBoarding API
        case .getProfile:
            return APIs.onBoardingBaseURL.appending("profile-detail")
        case .signUp:
            return APIs.onBoardingBaseURL.appending("signup")
        case .sendOtp:
            return APIs.onBoardingBaseURL.appending("send-otp")
        case .verifyOtp:
            return APIs.onBoardingBaseURL.appending("verify-otp")
        case .addGift:
            return APIs.onBoardingBaseURL.appending("add-gift")
        case .getAllGift:
            return APIs.onBoardingBaseURL.appending("get-gift")
        case .getDistance:
            return APIs.onBoardingBaseURL.appending("get-distence")
        case .emailLogin:
            return APIs.onBoardingBaseURL.appending("login")
        case .registerPassword:
            return APIs.onBoardingBaseURL.appending("/api/v1/user/register")
        case .changePassword:
            return APIs.onBoardingBaseURL.appending("/api/v1/user/changePassword")
        case .booking:
            return APIs.onBoardingBaseURL.appending("booking-add")
        case .bookingHistory:
            return APIs.onBoardingBaseURL.appending("booking-history")
        case .driverVechile:
            return APIs.onBoardingBaseURL.appending("get-drivers")
        case .getGraph:
            return APIs.onBoardingBaseURL.appending("gift-graph")
        case .updateProfile:
            return APIs.onBoardingBaseURL.appending("update-profile")
        case  .updateDriverStatus:
            return APIs.onBoardingBaseURL.appending("status-update")
        case .deleteNotification:
            return APIs.onBoardingBaseURL.appending("notifications-delete")
        case .deleteGift:
            return APIs.onBoardingBaseURL.appending("delete-gift")
        case .bookingStatus:
            return APIs.onBoardingBaseURL.appending("booking-status")
        case .driverBookingList:
            return APIs.onBoardingBaseURL.appending("booking-get")
        case .driverReviewList:
            return APIs.onBoardingBaseURL.appending("user_review")
        case .deleteAccount:
            return APIs.onBoardingBaseURL.appending("delete-account")
        case .notification:
            return APIs.onBoardingBaseURL.appending("get-notification")
        case .makeVehicle:
            return APIs.onBoardingBaseURL.appending("get-make")
        case .driverInformation:
            return APIs.onBoardingBaseURL.appending("driver_information")
        case .inspection:
            return APIs.onBoardingBaseURL.appending("get-center")
        case .basicDetail:
            return APIs.onBoardingBaseURL.appending("app-basic-details")
        case .rating:
            return APIs.onBoardingBaseURL.appending("review")
        case .termsCondition:
            return APIs.onBoardingBaseURL.appending("terms-conditions")
        case .privacypolicy:
            return APIs.onBoardingBaseURL.appending("terms-conditions")
        case .logOut:
            return APIs.onBoardingBaseURL.appending("logout")
        case .forgotPassword:
            return APIs.onBoardingBaseURL.appending("forgot-password")
        case .resetPassword:
            return APIs.onBoardingBaseURL.appending("change-password")
        case .uploadFile:
            return APIs.onBaseURL.appending("upload-image")
        case .saveCard:
            return APIs.onBoardingBaseURL.appending("card-save")
        case .deleteCard:
            return APIs.onBoardingBaseURL.appending("card-delete")
        case .socialLogin:
            return  APIs.onBoardingBaseURL.appending("social-login")
        case .GetUserLists:
           return  APIs.onBoardingBaseURL.appending("chat-list")
       case .GetChatLists:
          return  APIs.onBoardingBaseURL.appending("chat-detail")
        case .GetTermsConditions:
           return  APIs.onBoardingBaseURL.appending("terms-conditions")
        case .updateNotification:
           return  APIs.onBoardingBaseURL.appending("update-notification")
        case .addpayment:
           return  APIs.onBoardingBaseURL.appending("add-payment")
        }
    }
}
