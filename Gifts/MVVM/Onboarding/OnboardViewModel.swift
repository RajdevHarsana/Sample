//
//  OnboardViewModel.swift
//  YoomApplication
//
//  Created by sandeep on 03/01/22.
//

import Foundation
public typealias idAddress = String

class OnboardViewModel:NSObject{
    
    static let shared = OnboardViewModel()
    //MARK: OnBoarding

    func userSignUp(param: parameters, isAuthorization: Bool, completion:@escaping (SignUpModel) -> Void){
        
        NetworkManager.shared.fetch(type: SignUpModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .signUp, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func userPhoneLogin(param: parameters, isAuthorization: Bool, completion:@escaping (PhoneNumberModel) -> Void){

        NetworkManager.shared.fetch(type: PhoneNumberModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .sendOtp, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func userEmailLogin(param: parameters, isAuthorization: Bool, completion:@escaping (LoginDataModel) -> Void){

        NetworkManager.shared.fetch(type: LoginDataModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .emailLogin, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func userPhoneVerfyOTP(param: parameters, isAuthorization: Bool, completion:@escaping (VerifyOtpModel) -> Void){

        NetworkManager.shared.fetch(type: VerifyOtpModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .verifyOtp, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func booking(param: parameters, isAuthorization: Bool, completion:@escaping (BookingModel) -> Void){

        NetworkManager.shared.fetch(type: BookingModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .booking, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func GetBasicDetails(param: parameters, isAuthorization: Bool, completion:@escaping (BasicDeatilsModel) -> Void){

        NetworkManager.shared.fetch(type: BasicDeatilsModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .basicDetail, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func bookingStatus(param: parameters, isAuthorization: Bool, completion:@escaping (BookingRequestModel) -> Void){

        NetworkManager.shared.fetch(type: BookingRequestModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .bookingStatus, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func logOutApi(param: parameters, isAuthorization: Bool, completion:@escaping (LogOutModel) -> Void){

        NetworkManager.shared.fetch(type: LogOutModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .logOut, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func addpaymentApi(param: parameters, isAuthorization: Bool, completion:@escaping (LogOutModel) -> Void){

        NetworkManager.shared.fetchs(type: LogOutModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .addpayment, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func getDistanceApi(param: parameters, isAuthorization: Bool, completion:@escaping (GetDistanceModel) -> Void){

        NetworkManager.shared.fetch(type: GetDistanceModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .getDistance, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }

    func deleteAccount(param: parameters, isAuthorization: Bool, completion:@escaping (DeleteGiftModel) -> Void){

        NetworkManager.shared.fetch(type: DeleteGiftModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .deleteAccount, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func driverInfo(param: parameters, isAuthorization: Bool, completion:@escaping (DriverInformationModel) -> Void){

        NetworkManager.shared.fetch(type: DriverInformationModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .driverInformation, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func updateprofile(param: parameters, isAuthorization: Bool, completion:@escaping (UpdateProfileModel) -> Void){

        NetworkManager.shared.fetch(type: UpdateProfileModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .updateProfile, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func updateDriverProfile(param: parameters, isAuthorization: Bool, completion:@escaping (UpdateProfileModel) -> Void){

        NetworkManager.shared.fetch(type: UpdateProfileModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .driverInformation, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func updateDriverStatus(param: parameters, isAuthorization: Bool, completion:@escaping (DriverActiveModel) -> Void){

        NetworkManager.shared.fetch(type: DriverActiveModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .updateDriverStatus, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func userForgotPassword(param: parameters, isAuthorization: Bool, completion:@escaping (ForgotPasswordModel) -> Void){

        NetworkManager.shared.fetch(type: ForgotPasswordModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .forgotPassword, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func userChangePassword(param: parameters, isAuthorization: Bool, completion:@escaping (ChangePasswordModel) -> Void){

        NetworkManager.shared.fetch(type: ChangePasswordModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .resetPassword, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }

    func userSocialLogin(param: parameters, isAuthorization: Bool, completion:@escaping (SocialLoginModel) -> Void){

        NetworkManager.shared.fetch(type: SocialLoginModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .socialLogin, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
   
   
   
    func review(param: parameters, isAuthorization: Bool, completion:@escaping (RatingModel) -> Void){

        NetworkManager.shared.fetch(type: RatingModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .rating, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }

    func userGetProfile(param: parameters, isAuthorization: Bool, completion:@escaping (GetProfileModel) -> Void){

        NetworkManager.shared.fetch(type: GetProfileModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .getProfile, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func getGraph(param: parameters, isAuthorization: Bool, completion:@escaping (GraphModel) -> Void){

        NetworkManager.shared.fetch(type: GraphModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .getGraph, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func giftDelete(param: parameters, isAuthorization: Bool, completion:@escaping (DeleteGiftModel) -> Void){

        NetworkManager.shared.fetch(type: DeleteGiftModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .deleteGift, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func RequestGift(param: parameters, isAuthorization: Bool, completion:@escaping (BookingStatusModel) -> Void){

        NetworkManager.shared.fetch(type: BookingStatusModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .booking, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func SearchData(param: parameters, isAuthorization: Bool, completion:@escaping (GetGiftModel) -> Void){

        NetworkManager.shared.fetch(type: GetGiftModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .getAllGift, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    
    func inspectionGet(param: parameters, isAuthorization: Bool, completion:@escaping (InspectionModel) -> Void){

        NetworkManager.shared.fetch(type: InspectionModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .inspection, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func driverGetMakeVehicle(param: parameters, isAuthorization: Bool, completion:@escaping (MakeModel) -> Void){

        NetworkManager.shared.fetch(type: MakeModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .makeVehicle, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func userBookingHistory(param: parameters, isAuthorization: Bool, completion:@escaping (BookingHistoryModel) -> Void){

        NetworkManager.shared.fetch(type: BookingHistoryModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .bookingHistory, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func userBookingNotification(param: parameters, isAuthorization: Bool, completion:@escaping (NotificationModel) -> Void){

        NetworkManager.shared.fetch(type: NotificationModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .notification, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    

    func driverBookingHistory(param: parameters, isAuthorization: Bool, completion:@escaping (DriverBookinglistModel) -> Void){
        Loader.stop()
        NetworkManager.shared.fetch(type: DriverBookinglistModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .driverBookingList, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func driverVechicleSelection(param: parameters, isAuthorization: Bool, completion:@escaping (DriverVehicleModel) -> Void){

        NetworkManager.shared.fetch(type: DriverVehicleModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .driverVechile, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    
    func ratingListing(param: parameters, isAuthorization: Bool, completion:@escaping (RatingListModel) -> Void){

        NetworkManager.shared.fetch(type: RatingListModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .driverReviewList, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }

    func UploadProfileImage(image: Data, param: parameters, isAuthorization: Bool, completion:@escaping (UploadImageModel) -> Void){

        NetworkManager.shared.UploadImageWithParameters(type: UploadImageModel.self, image: image, api: .uploadFile, params: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                completion(result)
              }
        }
    }
    func addNewGift(image: Data, param: parameters, isAuthorization: Bool, completion:@escaping (AddNewGiftModel) -> Void){

        NetworkManager.shared.UploadImageWithParameters(type: AddNewGiftModel.self, image: image, api: .addGift, params: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }

    func logOutUser(param: parameters, isAuthorization: Bool, completion:@escaping (LogOutModel) -> Void){

        NetworkManager.shared.fetch(type: LogOutModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .logOut, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func GetChatUser(param: parameters, isAuthorization: Bool, completion:@escaping (chatListModal) -> Void){

        NetworkManager.shared.fetch(type: chatListModal.self, httpMethod: .post, isAutorization: isAuthorization, api: .GetUserLists, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func GetChatList(param: parameters, isAuthorization: Bool, completion:@escaping (chatListModal) -> Void){

        NetworkManager.shared.fetch(type: chatListModal.self, httpMethod: .post, isAutorization: isAuthorization, api: .GetChatLists, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func GetTermsList(param: parameters, isAuthorization: Bool, completion:@escaping (TermsModel) -> Void){

        NetworkManager.shared.fetchs(type: TermsModel.self, httpMethod: .get, isAutorization: isAuthorization, api: .GetTermsConditions, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
    func updateNotification(param: parameters, isAuthorization: Bool, completion:@escaping (LogOutModel) -> Void){

        NetworkManager.shared.fetch(type: LogOutModel.self, httpMethod: .post, isAutorization: isAuthorization, api: .updateNotification, parameter: param) { (success, result) in
            Loader.stop()
              if success{
                  guard let result = result else {return}
                  completion(result)
              }
        }
    }
}
