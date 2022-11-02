
import Foundation
import SDWebImage

let defaultValues = UserDefaults.standard
var accessToken = defaultValues.value(forKey: "accessToken") as? String ?? ""
var id = defaultValues.value(forKey: "id") as? String ?? ""
var firstName = defaultValues.value(forKey: "firstName") as? String ?? ""
var lastname = defaultValues.value(forKey: "firstName") as? String ?? ""
var email = defaultValues.value(forKey: "email") as? String ?? ""
var deviceToken = defaultValues.value(forKey: "deviceToken") as? String ?? ""
var latitude = defaultValues.value(forKey: "latitude") as? Double ?? 0.0
var longitude = defaultValues.value(forKey: "longitude") as? Double ?? 0.0
var deviceID = defaultValues.value(forKey: "deviceID") as? String ?? ""
var socialid = defaultValues.value(forKey: "socialid") as? String ?? ""
var index = defaultValues.value(forKey: "index") as? Int ?? 0
var option_one_id = defaultValues.value(forKey: "option_one_id") as? Int ?? 0
var option_Two_id = defaultValues.value(forKey: "option_Two_id") as? Int ?? 0
var parent_id = defaultValues.value(forKey: "parent_id") as? Int ?? 0
var language = defaultValues.value(forKey: "language") as? String ?? ""

// in-app-purchage

var monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
var yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
var createdAt = defaultValues.value(forKey: "createdAt") as? String ?? ""
var expireDate = defaultValues.value(forKey: "expireDate") as? String ?? ""

let guestId = "guestId"
let isLoggedIn = "isLoggedIn"
let selectedCountryFlag = "selectedCountryFlag"
let selectedCountryCode = "selectedCountryCode"
let user_LoginData = "user_LoginData"
let currentAddress = "currentAddress"
let orderType = "orderType"
let firebaseToken = "firebaseToken"
let selectedTableId = "selectedTableId"

let deviceType = "IOS"
func ShowDateToUSAFormat(datestring: String?) -> String {
    if let string = datestring{
        if string.count == 10{
            var returnString = ""
            let component = string.components(separatedBy: "-")
            returnString.append(component[1])
            returnString.append("-\(component[2])")
            returnString.append("-\(component[0])")
            return returnString
        }
    }
    return  ""
}
func ChangeTimetoLocal(datestring: String?) -> String {
    if let string = datestring{
        if string.count == 10{
            var returnString = ""
            let component = string.components(separatedBy: "-")
            returnString.append(component[2])
            returnString.append("-\(component[0])")
            returnString.append("-\(component[1])")
            return returnString
        }
    }
    return  ""
}
func getTime(timeString: String , format : String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let date = dateFormatter.date(from: timeString)// create   date from string
    
    // change to a readable time format and change to local time zone
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = NSTimeZone.local
    let timeStamp = dateFormatter.string(from: date ?? Date())
    return timeStamp
}
func StringToDate(dateStr: String, format: String) -> String {
    let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.long
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let convertedDate = dateFormatter.date(from: dateStr)
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss Z"
            let date = dateFormatter.string(from: convertedDate!)
            return date

 }
 func getDate(dateStr: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale.current
    return dateFormatter.date(from:dateStr) // replace Date String
}
func DatetoString(format : String , date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
   return dateFormatter.string(from: date)
}
