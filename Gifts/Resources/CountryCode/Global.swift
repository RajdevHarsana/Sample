//
//  Global.swift
//  Realtor_Property
//
//  Created by Geek Tech on 18/03/21.
//

import Foundation
import UIKit

class Global: NSObject {
    static var objGlobalMethod = Global()
    var isFromNotification = false
    var notificationOrderId = ""
    var outletId = ""
    var merchantId = ""
    var outletCurrency = "₹"
    
    var isGuestUser = false
    
    var BodyBgColor = ""
    var buttonColor = ""
    var buttonTextColor = ""
    var headerFooterBgColor = ""
    var headerFooterColor = ""
    var primaryColor = ""
    var textColor = ""
    
    var apiURL = ""
    var descriptionM = ""
    var title = ""
    var merchantURL = ""
    var appId = ""
    var emailLoginImage = ""
    var forgotPasswordImage = ""
    var phoneLoginImage = ""
    var splashscreenImage = ""
    var downloadImg1 = ""
    var downloadImg2 = ""
    
    
    
    
    
    var firebaseToken = ""
    
    
    private override init() { }
    
    func load(fileName: String) -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    func SaveToFileManager(path: String, data: Data){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(path)
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    
    func random_UUID() -> String {
        
        let length: Int = 20
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    func saveIsLoginUser(_ value:Bool){
        UserDefaults.standard.set(value, forKey: isLoggedIn)
    }
    func getIsLoginUser() -> Bool{
        return UserDefaults.standard.bool(forKey: isLoggedIn)
    }
    
    func saveUserData_UserDefaults(userData:SignUserData) {
        
        do {
            let data = try JSONEncoder().encode(userData)
            UserDefaults.standard.set(data, forKey: user_LoginData)
        }
        catch(let err) {
            print(err)
        }
    }
    func loadUserData_UserDefaults(userLoginData:String) -> SignUp_data? {
        
        
        if let data = UserDefaults.standard.data(forKey: userLoginData) {
            do {
                let userLoginData = try JSONDecoder().decode(SignUp_data.self, from: data)
                return userLoginData
            }
            catch(let err) {
                print(err)
            }
        }
        return nil
    }
    let df = DateFormatter()
    
    func convertISODateType(str_Date: String) -> Date {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df.date(from: str_Date) ?? Date()
    }
    
    func convertISOtoDate(str_Date: String) -> String {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateD = df.date(from: str_Date) {
            df.locale = Locale.current
            df.timeZone = TimeZone.current
            df.dateFormat = "dd-MM-yyyy"
            
            return df.string(from: dateD)
        } else {
            return "Unknown date"
        }
    }
    func convertISOtoDateTime(str_Date: String) -> String {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateD = df.date(from: str_Date) {
            df.locale = Locale.current
            df.timeZone = TimeZone.current
            df.dateFormat = "MMM dd, yyyy h:mm a"
            
            return df.string(from: dateD)
        } else {
            return "Unknown date"
        }
    }
    func convertISODate(str_Date: String) -> String {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateD = df.date(from: str_Date) {
            df.locale = Locale.current
            df.timeZone = TimeZone.current
            df.dateFormat = "MMM dd, yyyy"
            
            return df.string(from: dateD)
        } else {
            return "Unknown date"
        }
    }
    
    func convertISOTime(str_Date: String) -> String {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateD = df.date(from: str_Date) {
            df.locale = Locale.current
            df.timeZone = TimeZone.current
            df.dateFormat = "h:mm a"
            return df.string(from: dateD)
        } else {
            return "Unknown date"
        }
    }
    
    func convertISOtoTime(str_Date: String) -> String {
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:SSS'Z'"
        df.locale = Locale(identifier: "en_US_POSIX")
        df.timeZone = TimeZone(secondsFromGMT: 0)
        if let dateD = df.date(from: str_Date) {
            df.locale = Locale.current
            df.timeZone = TimeZone.current
            df.dateFormat = "h:mm a"
            return df.string(from: dateD)
        } else {
            return "Unknown date"
        }
    }
    
//    func convertStringtoDate(str_Date: String) -> String {
//        df.dateFormat = "EEE MMM d yyyy h:mm a" //   "EEE MMM d yyyy"
//        df.locale = Locale(identifier: "en_US_POSIX")
//        df.timeZone = TimeZone(secondsFromGMT: 0)
//        if let dateD = df.date(from: str_Date) {
//            df.locale = Locale.current
//            df.timeZone = TimeZone.current
//            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//            return df.string(from: dateD)
//        } else {
//            return "Unknown date"
//        }
//    }
    
//    func GusetLoginView(controller: UIViewController) {
//        let popvc = mainStoryboard.instantiateViewController(withIdentifier: "GuestLogin_VC") as! GuestLogin_VC
//        popvc.outletId = Global.objGlobalMethod.outletId
//        controller.addChild(popvc)
//        popvc.view.frame = controller.view.frame
//        controller.view.addSubview(popvc.view)
//        popvc.didMove(toParent: controller)
//    }
//
    func RemoveChildView(controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
    
    func ClearLoginData() {
        UserDefaults.standard.set(nil, forKey: user_LoginData)
        UserDefaults.standard.set(false, forKey: isLoggedIn)
        UserDefaults.standard.set(nil, forKey: selectedCountryCode)
        UserDefaults.standard.set(nil, forKey: currentAddress)
    }
    
    func getSetCountryCode() -> Bool {
        let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode)
        if countryCode != "" && countryCode != nil {
            //setSelectedCountry()
            return true
        }
        else {
            if let regionCode = Locale.current.regionCode {
                let resultArray = countryArray.filter {
                    $0["ISO"] == regionCode.lowercased()
                }
                if resultArray.count > 0 {
                    if let countryCode = resultArray[0]["Code"] {
                        let flag = flag(country: regionCode)
                        UserDefaults.standard.set("+\(countryCode)", forKey: selectedCountryCode)
                        UserDefaults.standard.set(flag, forKey: selectedCountryFlag)
                        //setSelectedCountry()
                        return true
                    }
                    else {
                        return false
                    }
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        }
    }
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
    func minMaxString(text: String, minValue: Int, maxValue: Int) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text + " ")
        
        let myAttribute: [NSAttributedString.Key : Any] = [ NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Rubik-Regular", size: 12.0) ?? UIFont.systemFont(ofSize: 14.0) ]
        var changeText = "(Min \(minValue) | Max \(maxValue))"
        if maxValue == 0 {
            changeText = ""
        }
        let myAttrString = NSAttributedString(string: " " + changeText, attributes: myAttribute)
        attributedString.append(myAttrString)
        return attributedString
    }
    
    func getMinutesDifferenceFromTwoDates(start: Date, end: Date) -> Int {
        
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)
        
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        return minutes
    }
    
    internal func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
                  return
              }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func setPriceStrikePrice(isPriceInTax: Bool, isPriceListActive : Bool, isPriceList: Bool, price: Double, priceInTax: Double, priceList: Double, priceListInTax: Double) -> (Double, String, Double, NSAttributedString) {
        
        var productPrice = 0.0
        var productStrikePrice = 0.0
        if !isPriceInTax && !isPriceListActive {
            productPrice = price
        }
        else if !isPriceInTax && isPriceListActive && !isPriceList{
            productPrice = price
        }
        
        else if isPriceInTax && isPriceListActive && !isPriceList{
            productPrice = priceInTax
        }
        else if !isPriceInTax && isPriceListActive && isPriceList {
            productPrice = priceList
            productStrikePrice = price
        }
        else if isPriceInTax && isPriceListActive && isPriceList {
            productPrice = priceListInTax
            productStrikePrice = priceInTax
        }
        
        let productPriceDisplay = "\(Global.objGlobalMethod.outletCurrency)\(String(format: "%.2f", productPrice))"
        
        let attributedText = NSAttributedString(
            string: "\(Global.objGlobalMethod.outletCurrency)\(String(format: "%.2f", productStrikePrice))",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        )
        
        return (productPrice, productPriceDisplay, productStrikePrice, attributedText)
    }
}


