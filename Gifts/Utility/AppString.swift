//
//  AppString.swift
//  Justruck
//
//  Created by Apple on 22/04/22.
//

import Foundation


let checkEmailForOTP = "Check Email for OTP"

let BOOKING_CHANGE = "bookingChange"
let JOIN_BOOKING = "joinBooking"
let LEAVE_BOOKING = "leaveBooking"

struct ErrorMessages {
    static let selectStore = "Please enter gift title."
    static let loginFirst = "Please login first."
    static let discription = "Please enter gift description."
    static let noDataFound = "No data found."
    static let addImages = "Please add gift images."
    static let checkInternetConnectivity = "Please check your internet and retry."
    static let somethingWentWrong = "Something went wrong. Please try again later."
    static let termsConditions = "Please select Terms & Conditions"
    static let DisclaimerMessage = "Please accept the disclaimer"

    //Email Validation
    static let alertAllFieldsRequired = "Please fill all the fields."
    static let alertEnterEmail = "Please enter email address."
    static let alertValidEmail = "Please enter valid email address."
    
    //Card Error Message
    static let inValidCardNumber = "Your card number is incorrect."
    
    //Phone Validation
    static let alertEnterPhoneNumber = "Please enter phone number."
    static let alertValidPhoneNumber = "Please enter 7-15 digit phone number."
    static let alertChooseCountryCode = "Please select country code."
    var confirmationCodeMessage = "Please enter confirmation code"
    //OTP Validation
    static let alertValidOTP = "Please enter valid OTP."
    
    //Enter Password
    static let alertEnterPassword = "Please enter password."
    static let alertEnterNewPassword = "Please new enter password."
    static let alertEnterCurrentPassword = "Please enter current password."
    static let alertEnterConfirmPassword = "Please enter confirm password."
    static let alertEnterValidPassword = "Password should be at least 8 characters and a combination of letters and digits."
    static let alertConfirmPasswordNotMatch = "Passwords does not match."
    
    //Edit Profile
    static let alertName = "Please enter name."
    static let alertFirstName = "Please enter first name."
    static let alertLastName = "Please enter last name."
    static let alertEmailEmpty = "Please enter email address."
    static let alertPhoneEmpty = "Phone number can't be empty."
    static let alertOccassion = "Please select occassion."
    
    //Add Address
    static let alertAddressEmpty = "Please select address."
    static let alertEnterNumberOfGuest = "Please enter number of guests."
    
    //Table Booking
    static let alertNoDatesAvailale = "No dates available."
    static let alertNoTimeAvailale = "No time slots available."
    
    //Rating
    static let alertRating = "Please review us."

   
}

struct SuccessMessages {
    static let loginSuccessfully = "Login Successfully"
    static let SentPasswordSuccessfully = "Sent Password Successfully"
    //Address
    static let addressAdded = "Address added successfully."
    static let addressDeleted = "Address deleted successfully."
    static let addressUpdated = "Address updated successfully."
    
    static let ChangePasswordSuccessfully = "Change Password Successfully"
    
    //Favourite
    static let addToFav = "Added to favourite successfully."
    static let deleteFromFav = "Removed from favourite successfully."
}

struct Alert {
    static let buttonOK = "OK"
    static let alertTitle = "Alert!"
    static let countryCodeNotFound = "Country code Not found!"
}



