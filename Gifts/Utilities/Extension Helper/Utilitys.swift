////
////  PiratesCabinVC.swift
////  Gifts
////
////  Created by PBS9 on 16/07/19.
////  Copyright © 2019 Dinesh Raja. All rights reserved.
////
//
//import Foundation
//import UIKit
//import MapKit
//class Utility{
//    static func showAlertMessage(vc: UIViewController?, titleStr:String, messageStr:String) -> Void{
//        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert);
//        let action = UIAlertAction.init(title: "ok", style: .default, handler: nil)
//        alert.addAction(action)
//        if (vc == nil){
//            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
//                window.rootViewController?.present(alert, animated: true, completion: nil)
//            }
//        }else{
//            vc?.present(alert, animated: true, completion: nil)
//        }
//    }
//}
//class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
//    
//    var months: [String]!
//    var years: [Int]!
//    var month = Calendar.current.component(.month, from: Date()) {
//        didSet {
//            selectRow(month-1, inComponent: 0, animated: false)
//        }
//    }
//    var year = Calendar.current.component(.year, from: Date()) {
//        didSet {
//            selectRow(years.firstIndex(of: year)!, inComponent: 1, animated: true)
//        }
//    }
//    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.commonSetup()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        self.commonSetup()
//    }
//    func commonSetup() {
//        var years: [Int] = []
//        if years.count == 0 {
//            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
//            for _ in 1...15 {
//                years.append(year)
//                year += 1
//            }
//        }
//        self.years = years
//        var months: [String] = []
//        var month = 0
//        for _ in 1...12 {
//            months.append(DateFormatter().monthSymbols[month].capitalized)
//            month += 1
//        }
//        self.months = months
//        self.delegate = self
//        self.dataSource = self
//        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
//        self.selectRow(currentMonth - 1, inComponent: 0, animated: false)
//    }
//    // Mark: UIPicker Delegate / Data Source
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 2
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//        case 0:
//            return months[row]
//        case 1:
//            return "\(years[row])"
//        default:
//            return nil
//        }
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//        case 0:
//            return months.count
//        case 1:
//            return years.count
//        default:
//            return 0
//        }
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let month = self.selectedRow(inComponent: 0) + 1
//        let year = years[self.selectedRow(inComponent: 1)]
//        if let block = onDateSelected {
//            block(month, year)
//        }
//        self.month = month
//        self.year = year
//    }
//}
////For the RoundedButton with border color and cornerradius also for UIButton.
//@IBDesignable
////class RoundButton: UIButton {
////    @IBInspectable var cornerRadius: CGFloat = 0{
////        didSet{
////            self.layer.cornerRadius = cornerRadius
////        }
////    }
////    @IBInspectable var borderWidth: CGFloat = 0{
////        didSet{
////            self.layer.borderWidth = borderWidth
////        }
////    }
////    @IBInspectable var borderColor: UIColor = UIColor.clear{
////        didSet{
////            self.layer.borderColor = borderColor.cgColor
////        }
////    }
////}
////For the Roundedview with border color and cornerradius also for UIView.
//@IBDesignable
////class RoundedView: UIView {
////    @IBInspectable var cornerRadius: CGFloat = 0{
////        didSet{
////            self.layer.cornerRadius = cornerRadius
////        }
////    }
////    @IBInspectable var borderWidth: CGFloat = 0{
////        didSet{
////            self.layer.borderWidth = borderWidth
////        }
////    }
////    @IBInspectable var borderColor: UIColor = UIColor.clear{
////        didSet{
////            self.layer.borderColor = borderColor.cgColor
////        }
////    }
////    @IBInspectable var rightSideCorner: CGFloat = 0{
////        didSet{
////            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
////        }
////    }
////}
//extension String {
//    var isNumeric: Bool {
//        guard self.count > 0 else { return false }
//        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
//        return Set(self).isSubset(of: nums)
//    }
//}
//extension UIImageView{
//  func setImageviewCorner(){
//    self.layer.borderColor = BaseViewController.appColor.cgColor
//    self.layer.borderWidth = 1.0
//    self.layer.cornerRadius = self.frame.height/2
//    self.clipsToBounds = true
//  }
//  func setImageBorderColor(value:CGFloat){
//      self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//      self.layer.shadowOpacity = 0.3
//      self.layer.shadowRadius = 1
//      self.layer.cornerRadius = value
//      self.clipsToBounds = true
//    }
//}
//extension UIButton{
//  func setCornerOfButton(){
//    self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//    self.layer.shadowOpacity = 0.3
//    self.layer.shadowRadius = 1
//    self.layer.cornerRadius = self.frame.height/2
//    self.layer.masksToBounds =  false
//  }
//  func setButtonCornerRadius(Value:CGFloat){
//    self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//    self.layer.shadowOpacity = 0.3
//    self.layer.shadowRadius = 1
//    self.layer.cornerRadius = Value
//    self.layer.masksToBounds =  false
//  }
//    
//}
//extension UIView{
//     func setShadowForView(){
//         self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//         self.layer.shadowOpacity = 0.3
//         self.layer.shadowRadius = 1
//         self.layer.cornerRadius = self.frame.height/2
//         self.layer.masksToBounds =  false
//       }
//       func setCornerRadius(value:CGFloat){
//         self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//         self.layer.shadowOpacity = 0.3
//         self.layer.shadowRadius = 1
//         self.layer.cornerRadius = value
//         self.layer.masksToBounds =  false
//        
//       }
//      func setBorderView(value:CGFloat,Color:CGColor,wValue: CGFloat){
//        self.layer.cornerRadius = value
//        self.layer.borderColor = Color
//        self.layer.borderWidth = wValue
//        self.clipsToBounds = true
//     }
//     func setMaxCornerRadius(value:CGFloat,color:CGColor){
//        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowRadius = 1
//        self.layer.cornerRadius = value
//        self.layer.shadowColor = color
//        self.layer.masksToBounds =  false
//    }
//}
//extension UIButton{
//    func setCornerRadiusOfButton(value:CGFloat){
//        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.1)
//        self.layer.shadowOpacity = 0.2
//        self.layer.shadowRadius = 1
//        self.layer.cornerRadius = 5
//        self.layer.masksToBounds =  false
//    }
//}
//extension UILabel{
//  func setMaxLabelCornerRadius(value:CGFloat){
//        self.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
//         self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//         self.layer.shadowOpacity = 0.3
//         self.layer.shadowRadius = 1
//         self.layer.cornerRadius = value
//         self.clipsToBounds = true
//     }
//}
//extension UIViewController{
//    //Mark:- Validations
//    // Verifying valid Email or Not
//    func isValidEmail(testStr:String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: testStr)
//    }
//    // vrify Valid PhoneNumber or Not
//    func isValidPhone(phone: String) -> Bool {
//        let phoneRegex = "^[0-9]{10}$";
//        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
//        return valid
//    }
//    // Show AlertMessage
////    func showAlert(_ title: String, _ message:String,_ buttonTitle:String){
////        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
////        let action = UIAlertAction(title: buttonTitle, style: .default) { (action: UIAlertAction) in
////
////        }
////        alert.addAction(action)
////        present(alert, animated: true, completion: nil)
////    }
//    func addsubView(subView:UIView , superView:UIView){
//        let topConstraint = NSLayoutConstraint(item: superView, attribute: .top, relatedBy: .equal, toItem: subView , attribute: .top, multiplier: 1, constant: 0)
//        let bottomConstraint = NSLayoutConstraint(item: superView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
//        let leadingConstraint = NSLayoutConstraint(item: superView, attribute: .leading, relatedBy: .equal, toItem: subView, attribute: .leading, multiplier: 1, constant: 0)
//        let trailingConstraint = NSLayoutConstraint(item: superView, attribute: .trailing, relatedBy: .equal, toItem: subView, attribute: .trailing, multiplier: 1, constant: 0)
//        subView.addSubview(superView)
//        subView.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
//        subView.layoutIfNeeded()
//    }
//    func formatDate(date: String) -> String {
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .none
//        let dateObj: Date? = dateFormatterGet.date(from: date)
//        return dateFormatter.string(from: dateObj!)
//    }
//    func calculateAgeYears(dob:String) -> String{
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "dd-mm-yyyy"
//        let dateObj: Date? = dateFormatterGet.date(from: dob)
//        if dateObj == nil {
//            return "26"
//        }
//        else{
//        let now = NSDate()
//            let calendar : NSCalendar = NSCalendar.current as NSCalendar
//        let ageComponents = calendar.components(.year, from: dateObj!, to: now as Date, options: [])
//            let age = ageComponents.year!
//            return  String(age)
//        }
//    }
//    func convertLocalToUTC(localTime: String) -> String? {
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        dateFormatter.timeZone = NSTimeZone.local
//        let timeLocal = dateFormatter.date(from: localTime)
//        if timeLocal != nil {
//            dateFormatter.timeZone = TimeZone.init(abbreviation: "UTC")
//            let timeUTC = dateFormatter.string(from: timeLocal!)
//            return timeUTC
//        }
//        return nil
//    }
//    func currencyFormat(_ value: String?) -> String {
//        guard value != nil else { return "$0.00" }
//        let doubleValue = Double(value!) ?? 0.0
//        let formatter = NumberFormatter()
//        formatter.currencyCode = "USD"
//        formatter.currencySymbol = "$"
//        formatter.minimumFractionDigits = (value!.contains(".00")) ? 0 : 2
//        formatter.maximumFractionDigits = 2
//        formatter.numberStyle = .currencyAccounting
//        return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
//    }
//    func numbFormat(_ someString: String?) -> NSNumber {
//        guard someString != nil else { return 0000 }
//        let doubleValue = Double(someString!) ?? 0000
//        let myInteger = Int(doubleValue)
//        let myNumber = NSNumber(value:myInteger)
//        return myNumber
//    }
//    func getfeetAndInches(_ centimeter: Float) -> String? {
//       let totalHeight = centimeter / 30.48
//       let myFeet = Float(Int(totalHeight)) //returns 5 feet
//       let myInches = fabsf((totalHeight - myFeet) * 12)
//       return String(format: "%d ft %d in", Int(myFeet), roundf(myInches))
//   }
//    func getFeetToCentimeters(feet:String,inches:String) -> String{
//        let height = Double(feet) ?? 0.0 + Double(Double(inches)!/12.0)
//        let heightInCms = Double(height * 30.48)
//        return String(heightInCms)
//    }
//    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
//        let theta = lon1 - lon2
//        var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
//        dist = acos(dist)
//        dist = rad2deg(rad: dist)
//        dist = dist * 60 * 1.1515
//        if (unit == "K") {
//                dist = dist * 1.609344
//            }
//            else if (unit == "N") {
//                dist = dist * 0.8684
//            }
//        return dist
//    }
//    func deg2rad(deg:Double) -> Double {
//        return deg * Double.pi / 180
//    }
//
//    func rad2deg(rad:Double) -> Double {
//        return rad * 180.0 / Double.pi
//    }
//}
////Maximum length of characters for text field
//private var __maxLengths = [UITextField: Int]()
//extension UITextField {
//    @IBInspectable var maxLength: Int {
//        get {
//            guard let l = __maxLengths[self] else {
//                return 150 // (global default-limit. or just, Int.max)
//            }
//            return l
//        }
//        set {
//            __maxLengths[self] = newValue
//            addTarget(self, action: #selector(fix), for: .editingChanged)
//        }
//    }
////    @objc func fix(textField: UITextField) {
////        let t = textField.text
////        textField.text = t?.safelyLimitedTo(length: maxLength)
////    }
//    @IBInspectable var placeHolderColor: UIColor? {
//            get {
//                return self.placeHolderColor
//            }
//            set {
//                self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
//            }
//    }
//    func setLeftPaddingPoints(){
//            let paddingView = UIView(frame: CGRect(x: 0, y: 20, width: 20, height: self.frame.size.height))
//            self.leftView = paddingView
//            self.leftViewMode = .always
//        }
//        func setRightPaddingPoints() {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width-40, height: self.frame.size.height))
//            self.rightView = paddingView
//            self.rightViewMode = .always
//        }
//}
//extension String{
////    func safelyLimitedTo(length n: Int)->String {
////        if (self.count <= n) {
////            return self
////        }
////        return String( Array(self).prefix(upTo: n) )
////    }
////    var numberValue: NSNumber? {
////        if let value = Int(self) {
////            return NSNumber(value: value)
////        }
////        return nil
////    }
//    func capitalizingFirstLetter() -> String {
//          return prefix(1).capitalized + dropFirst()
//      }
//      mutating func capitalizeFirstLetter() {
//          self = self.capitalizingFirstLetter()
//      }
//}
////MARK:- Button Text UnderLine
//extension UIButton {
//    func underline() {
//        guard let text = self.titleLabel?.text else { return }
//        let attributedString = NSMutableAttributedString(string: text)
//        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
//        self.setAttributedTitle(attributedString, for: .normal)
//    }
//}
////MARK:- Label Text UnderLine
//extension UILabel {
//    func underline() {
//        if let textString = self.text {
//            let attributedString = NSMutableAttributedString(string: textString)
//            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
//            attributedText = attributedString
//        }
//    }
//}
//extension UIButton{
//    func setButtonCorner(value:CGFloat){
//      self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//      self.layer.shadowOpacity = 0.3
//      self.layer.shadowRadius = 1
//      self.layer.cornerRadius = value
//      self.layer.masksToBounds =  false
//    }
//    func applyGradient(){
//        let colorTop = UIColor(red: 83.0 / 255.0, green: 164.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 155.0 / 255.0, green: 221.0 / 255.0, blue: 179.0 / 255.0, alpha: 1.0).cgColor
//        let gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = self.bounds
//        gradient.colors =  [colorTop, colorBottom]
//        gradient.locations = [0.0, 1.0]
//        self.layer.insertSublayer(gradient, at: 0)
//    }
//}
//extension UIView {
//    func setShadowWithColor(){
//        self.layer.shadowColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//        self.layer.shadowRadius = 1
//        self.layer.masksToBounds =  false
//      }
//      func setShadowCornerWithValue(value:CGFloat){
//           self.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//           self.layer.shadowOpacity = 0.3
//           self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
//           self.layer.shadowRadius = 1
//           self.layer.cornerRadius = value
//           self.layer.masksToBounds =  false
//       }
//      func setOnSideCorner(outlet:UIView){
//        //Corner radius for view.
//        outlet.clipsToBounds = true
//        outlet.layer.cornerRadius = 15
//        outlet.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner]
//     }
//     func setOnbottomCorner(outlet:UIView){
//           //Corner radius for view.
//           outlet.clipsToBounds = true
//           outlet.layer.cornerRadius = 25
//           outlet.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
//       }
////       func dropShadow(view: UIView, opacity: Float){
////        view.layer.shadowColor = UIColor.black.cgColor
////        view.layer.shadowOpacity = 0.3
////        view.layer.shadowOffset = CGSize(width: 0.5, height: 0.3)
////        view.layer.shadowRadius = 1
////        view.layer.cornerRadius = 10
////     }
//     func dropShadowGradientBackground(view: UIView, opacity: Float){
//       view.layer.shadowColor =  UIColor (red: 94.0/255.0, green: 278.0/255.0, blue: 60/255.0, alpha: 1.0).cgColor
//       view.layer.shadowOpacity = 0.3
//       view.layer.shadowOffset = CGSize(width: 0.5, height: 0.3)
//       view.layer.shadowRadius = 10
//       view.layer.cornerRadius = 10
//    }
//}
//extension NSString {
//    func convertToDictionary(text: String) -> Any? {
//       do {
//            let data  = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: .allowFragments) as? Array<Dictionary<String, Any>>
//            return data
//        }
//        catch{
//            print ("Handle error")
//        }
//        return nil
//    }
//}
//extension String {
//    func fromBase64() -> String? {
//        guard let data = Data(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 0)) else {
//            return nil
//        }
//        return String(data: data as Data, encoding: String.Encoding.utf8)
//    }
//    func toBase64() -> String? {
//        guard let data = self.data(using: String.Encoding.utf8) else {
//            return nil
//        }
//        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//    }
//}
//extension UserDefaults {
//    public func optionalInt(forKey defaultName: String) -> Int? {
//        let defaults = self
//        if let value = defaults.value(forKey: defaultName) {
//            return value as? Int
//        }
//        return nil
//    }
//}
//extension UILabel {
//    func retrieveTextHeight () -> CGFloat {
//        let attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.font:self.font ?? ""])
//        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
//        return ceil(rect.size.height)
//    }
//}
//extension CLLocation {
//    /// Returns a distance in meters from a starting location to a destination location.
//    func calculateDrivingDistance(to destination: CLLocation, completion: @escaping(CLLocationDistance?) -> Void){
//        let request = MKDirections.Request()
//        let startingPoint = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(self.coordinate.latitude, self.coordinate.longitude)))
//        let endingPoint = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(destination.coordinate.latitude, destination.coordinate.longitude)))
//        request.source = startingPoint
//        request.destination = endingPoint
//        let directions = MKDirections(request: request)
//        directions.calculate { (response, error) in
//            if error != nil {
//                assertionFailure("Failed to calculate driving distance. \(String(describing: error))")
//            }
//            guard let data = response else { return }
//            let meterDistance = data.routes.first?.distance
//            completion(meterDistance)
//        }
//    }
//}
//extension UIView{
//    func animShow(){
//        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
//                       animations: {
//                        self.center.y -= self.bounds.height
//                        self.layoutIfNeeded()
//        }, completion: nil)
//        self.isHidden = false
//    }
//    func animHide(){
//        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
//                       animations: {
//                        self.center.y += self.bounds.height
//                        self.layoutIfNeeded()
//
//        },  completion: {(_ completed: Bool) -> Void in
//        self.isHidden = true
//            })
//    }
//}
//extension UIScrollView {
//       func scrollToView(view:UIView, animated: Bool) {
//        if let origin = view.superview {
//            let childStartPoint = origin.convert(view.frame.origin, to: self)
//            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y-100,width: 1,height: self.frame.height), animated: animated)
//        }
//    }
//}
//extension UISegmentedControl {
//    func font(name:String?, size:CGFloat?) {
//        let attributedSegmentFont = NSDictionary(object: UIFont(name: name!, size: size!)!, forKey: NSAttributedString.Key.font as NSCopying)
//        setTitleTextAttributes(attributedSegmentFont as [NSObject : AnyObject] as? [NSAttributedString.Key : Any], for: .normal)
//    }
//}
////extension UIApplication {
////    var statusBarView: UIView?{
////        return value(forKey: "statusBar") as? UIView
////    }
////    func statusBarmanager() {
////        if #available(iOS 13.0, *) {
////                      let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
////                      let statusBar = UIView(frame: window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
////               statusBar.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
////                      window?.addSubview(statusBar)
////               } else {
////                      UIApplication.shared.statusBarView?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
////               }
////      }
////}
//extension UITabBar {
//    func setTabbar(view: UIView){
//        var tabFrame:CGRect =  self.frame
//         tabFrame.origin.y = view.safeAreaInsets.top
//         self.frame = tabFrame
//        view.bringSubviewToFront(self)
//        self.unselectedItemTintColor = #colorLiteral(red: 0.7810397744, green: 0.7810582519, blue: 0.7810482979, alpha: 1)
//        self.tintColor = BaseViewController.appColor.withAlphaComponent(1.0)
//        UITabBar.appearance().shadowImage     = UIImage()
//        UITabBar.appearance().clipsToBounds   = true
//        view.layoutIfNeeded()
//    }
//}
//
////class GradientView: UIView {
////    override open class var layerClass: AnyClass {
////       return CAGradientLayer.classForCoder()
////    }
////    required init?(coder aDecoder: NSCoder) {
////        super.init(coder: aDecoder)
////        let gradientLayer = layer as! CAGradientLayer
////        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
////        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
////        gradientLayer.colors = [UIColor.green.cgColor, UIColor.white.cgColor]
////    }
////}
//@IBDesignable
//public class Gradient: UIView {
//    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
//    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
//    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
//    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
//    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
//    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
//
//    override public class var layerClass: AnyClass { CAGradientLayer.self }
//
//    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
//
//    func updatePoints() {
//        if horizontalMode {
//            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
//            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
//        } else {
//            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
//            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
//        }
//    }
//    func updateLocations() {
//        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
//    }
//    func updateColors() {
//        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
//    }
//    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        updatePoints()
//        updateLocations()
//        updateColors()
//    }
//}
//extension UIView {
//
//func setGradientBackground() {
//    let colorTop =  #colorLiteral(red: 0.4318315983, green: 0.7366300225, blue: 0.2952849865, alpha: 1)
//    let colorBottom = #colorLiteral(red: 0.3463228345, green: 0.5962414742, blue: 0.2396123409, alpha: 1)
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
//    gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
//    gradientLayer.frame = self.bounds
//    gradientLayer.cornerRadius = 10
//    self.layer.shadowOffset = CGSize(width: 0, height: 2)
//    self.layer.shadowOpacity = 0.3
//    self.layer.shadowRadius = 3.0
//    self.layer.shadowColor = UIColor.black.cgColor
//    self.layer.masksToBounds = false
//    self.layer.insertSublayer(gradientLayer, at: 0)
//    }
//}
//extension UITapGestureRecognizer {
//    
//    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
//           // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
//           let layoutManager = NSLayoutManager()
//           let textContainer = NSTextContainer(size: CGSize.zero)
//           let textStorage = NSTextStorage(attributedString: label.attributedText!)
//
//           // Configure layoutManager and textStorage
//           layoutManager.addTextContainer(textContainer)
//           textStorage.addLayoutManager(layoutManager)
//
//           // Configure textContainer
//           textContainer.lineFragmentPadding = 0.0
//           textContainer.lineBreakMode = label.lineBreakMode
//           textContainer.maximumNumberOfLines = label.numberOfLines
//           let labelSize = label.bounds.size
//           textContainer.size = labelSize
//
//           // Find the tapped character location and compare it to the specified range
//           let locationOfTouchInLabel = self.location(in: label)
//           let textBoundingBox = layoutManager.usedRect(for: textContainer)
//           let textContainerOffset = CGPoint(
//               x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
//               y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
//           )
//           let locationOfTouchInTextContainer = CGPoint(
//               x: locationOfTouchInLabel.x - textContainerOffset.x,
//               y: locationOfTouchInLabel.y - textContainerOffset.y
//           )
//           let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//
//           return NSLocationInRange(indexOfCharacter, targetRange)
//       }
//
//    
//}
