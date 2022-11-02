//
//  SettingVC.swift
//  PRS
//
//  Created by MacbookPro2020 on 22/12/21.
//
import UIKit
import Alamofire
import StoreKit
struct Fonts {
    static func heavyFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Avenir-Heavy", size: size)!
    }
    static func mediumFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Avenir-Medium", size: size)!
    }
}
struct Colors {
    static let carmine = UIColor.black
    static let greyColor = UIColor.black
    static let whiteColor = UIColor.white
    static let blueColor = UIColor.blue
}
class SettingVC: BaseViewController , UITextFieldDelegate {
    
    @IBOutlet weak var tfLanguage: UITextField!
    @IBOutlet weak var viewLanguage: UIView!
    @IBOutlet weak var App_version: UILabel!
    @IBOutlet weak var logout: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var TermView: UIView!
    @IBOutlet weak var privancyView: UIView!
    @IBOutlet weak var subscriptionView: UIView!
    @IBOutlet weak var btnSubsCription: UIButton!
    @IBOutlet weak var expiryLbl: UILabel!
    @IBOutlet weak var termsPrivancyLbl: UILabel!
    @IBOutlet weak var ViewConstraints: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var arrbasicDetails : [String] = []
    var productsArray = [SKProduct]()
    var activePlan = NSMutableArray()
    var textArray = [String]()
    var fontArray = [UIFont]()
    var colorArray = [UIColor]()
    var termsconditions = ""
    var privacypolicy = ""
    var HelpUs = ""
    let arrlanguage = ["English", "Spanish"]
    var langPicker = UIPickerView()
    var isActive = false
    var YearArray = [String]()

    @IBOutlet weak var yearSubscriptionView: UIView!
    @IBOutlet weak var yearbtnSubsCription: UIButton!
    @IBOutlet weak var yearexpiryLbl: UILabel!
    @IBOutlet weak var yeartermsPrivancyLbl: UILabel!

    var arrSettings:[[String:String]] = [["image":"rate","name":"Rate us","description":""],
                                         ["image":"notification-settingicon","name":"Notification Settings","description":"All Notifications "],
                                         ["image":"term","name":"Terms & Conditions","description":"T&C"],
                                         ["image":"privacy-settingicon","name":"Privacy","description":"Only me"],
                                         ["image":"change_password","name":"Change Password","description":""],
                                         ["image":"delete","name":"Delete Account","description":""],
                                         ["image":"help-settingicon","name":"Help","description":"Questions?"],
                                         ["image":"logout-1","name":"Logout","description":""]
                                         
    ]
    var discrp = ["","","","","","","","",""]
    var rateUsOnApplrStore = ""
    let cellSpacingHeight: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5.0
        tableView.rowHeight = 95
        self.tableView.showsHorizontalScrollIndicator = false
        self.tableView.showsVerticalScrollIndicator = false
        if UserStoreSingleton.shared.is_Come_FromSocial == true {
            arrSettings.remove(at: 4)
        }
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        getBasicDetails()
        setInitials()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
            if(keyPath == "contentSize"){
                if let tbl = object as? UITableView{
                    if tbl == self.tableView{
                        if let newvalue = change?[.newKey] {
                            let newsize = newvalue as! CGSize
                            self.ViewConstraints.constant = newsize.height
                        }
                    }
             }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
        super.viewWillAppear(animated)
    }
    func setInitials(){
        // monthly
        subscriptionView.layer.shadowColor = UIColor.gray.cgColor
        subscriptionView.layer.shadowOpacity = 0.3
        subscriptionView.layer.shadowOffset = CGSize.zero
        subscriptionView.layer.shadowRadius = 6
        subscriptionView.layer.cornerRadius = 10.0
        textArray.append(NSLocalizedString("By tapping Subscribe, payment will be charged to your iTunes account and your subscription will automatically renew for same amount each month until you cancel in setting in the iTunes Store at least 24 hours prior to the end of current period.  This subscription will allow you full access to this app including unlimited adding new gifts, receive gifts, dashboard of your prior transactions and notifications. By tapping subscribe you agree to our ", comment: ""))
        textArray.append(NSLocalizedString("Privacy Policy", comment: ""))
        textArray.append(NSLocalizedString("and", comment: ""))
        textArray.append(NSLocalizedString("Terms of Services.", comment: ""))
        fontArray.append(Fonts.mediumFontWithSize(size: 15.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 15.0))
        fontArray.append(Fonts.mediumFontWithSize(size: 15.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 15.0))
        colorArray.append(Colors.greyColor)
        colorArray.append(Colors.carmine)
        colorArray.append(Colors.greyColor)
        colorArray.append(Colors.carmine)
        self.termsPrivancyLbl.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        self.termsPrivancyLbl.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.termsPrivancyLbl.addGestureRecognizer(tapgesture)
        // yearly
        yearSubscriptionView.layer.shadowColor = UIColor.gray.cgColor
        yearSubscriptionView.layer.shadowOpacity = 0.3
        yearSubscriptionView.layer.shadowOffset = CGSize.zero
        yearSubscriptionView.layer.shadowRadius = 6
        yearSubscriptionView.layer.cornerRadius = 10.0
        YearArray.append(NSLocalizedString("By tapping Subscribe, payment will be charged to your iTunes account and your subscription will automatically renew for same amount each year until you cancel in setting in the iTunes Store at least 24 hours prior to the end of current period.  This subscription will allow you full access to this app including unlimited adding new gifts, receive gifts, dashboard of your prior transactions and notifications. By tapping subscribe you agree to our ", comment: ""))
        YearArray.append(NSLocalizedString("Privacy Policy", comment: ""))
        YearArray.append(NSLocalizedString("and", comment: ""))
        YearArray.append(NSLocalizedString("Terms of Services.", comment: ""))
        fontArray.append(Fonts.mediumFontWithSize(size: 15.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 15.0))
        fontArray.append(Fonts.mediumFontWithSize(size: 15.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 15.0))
        colorArray.append(Colors.greyColor)
        colorArray.append(Colors.carmine)
        colorArray.append(Colors.greyColor)
        colorArray.append(Colors.carmine)
        self.yeartermsPrivancyLbl.attributedText = getAttributedString(arrayText: YearArray, arrayColors: colorArray, arrayFonts: fontArray)
        self.yeartermsPrivancyLbl.isUserInteractionEnabled = true
        let tapgestures = UITapGestureRecognizer(target: self, action: #selector(YeartappedOnLabel(_ :)))
        tapgestures.numberOfTapsRequired = 1
        self.yeartermsPrivancyLbl.addGestureRecognizer(tapgesture)
        
        subscriptionConfig()
        YearsubscriptionConfig()
        
        PKIAPHandler.shared.setProductIds(ids: [BaseViewController.Monthly,BaseViewController.Yearly])
        PKIAPHandler.shared.fetchAvailableProducts { [weak self](products)   in
            print("products",products)
            guard let sSelf = self else {return}
            sSelf.productsArray = products
            print("price",self?.productsArray[0].price ?? 0)
            print("productIdentifier",self?.productsArray[0].productIdentifier ?? "")
            print("price",self?.productsArray[1].price ?? 0)
            print("productIdentifier",self?.productsArray[1].productIdentifier ?? "")
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5.0
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        App_version.text = "Version " + (appVersion ?? "1.0")
        
    }
    //MARK:- tappedOnLabel
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsPrivancyLbl.text else { return }
        let Privacy = (text as NSString).range(of: NSLocalizedString("Privacy Policy", comment: ""))
        let Terms = (text as NSString).range(of: NSLocalizedString("Terms of Services.", comment: ""))
        if gesture.didTapAttributedTextInLabel(label: self.termsPrivancyLbl, inRange: Privacy) {
            print("Privacy Policy")
            if let url = URL(string: "") {
                UIApplication.shared.open(url)
            }
          } else if gesture.didTapAttributedTextInLabel(label: self.termsPrivancyLbl, inRange: Terms){
            print("Terms.")
            if let url = URL(string: "") {
                UIApplication.shared.open(url)
            }
        }
    }
    //MARK:- tappedOnLabel
    @objc func YeartappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsPrivancyLbl.text else { return }
        let Privacy = (text as NSString).range(of: NSLocalizedString("Privacy Policy", comment: ""))
        let Terms = (text as NSString).range(of: NSLocalizedString("Terms of Services.", comment: ""))
        if gesture.didTapAttributedTextInLabel(label: self.yeartermsPrivancyLbl, inRange: Privacy) {
            print("Privacy Policy")
            if let url = URL(string: "") {
                UIApplication.shared.open(url)
            }
          } else if gesture.didTapAttributedTextInLabel(label: self.yeartermsPrivancyLbl, inRange: Terms){
            print("Terms.")
            if let url = URL(string: "") {
                UIApplication.shared.open(url)
            }
        }
    }
    //MARK:- getAttributedString
    func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?, arrayFonts:[UIFont]?) -> NSMutableAttributedString {
        
        let finalAttributedString = NSMutableAttributedString()
        
        for i in 0 ..< (arrayText?.count)! {
            
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
            
            if i != 0 {
                
                finalAttributedString.append(NSAttributedString.init(string: " "))
            }
            
            finalAttributedString.append(attributedStr)
        }
        
        return finalAttributedString
    }
    func subscriptionConfig(){
        let utcTime = UserStoreSingleton.shared.createdAt ?? ""
        print("utcTime",utcTime)
        let dateFormatterT = DateFormatter()
        dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatterT.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let startDate = dateFormatterT.date(from: utcTime)
        var dayComponent = DateComponents()
        dayComponent.day = 90
        let theCalendar = Calendar.current
        let firstDates = theCalendar.date(byAdding: dayComponent, to: startDate ?? Date())
        let Selecteddate =  DatetoString(format: "YYYY-MM-dd HH:mm:ss", date: firstDates ?? Date())
        let Showdate =  DatetoString(format: "MM-dd-yyyy", date: firstDates!)
        print("Showdate-------",Showdate)
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let today = dateFormatter.string(from: now)
        let FreeTodayDate = formatter.date(from: today)
        let FreeTrialDate = formatter.date(from: Selecteddate)
        print("FreeTrialDate----",FreeTrialDate ?? "")
        print("FreeTodayDate-----",FreeTodayDate ?? "")
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedDescending {
            print("First Date is greater then second date")
            let expire = UserStoreSingleton.shared.expiry_date ?? ""
            print("expire",expire)
            let dateFormatterT = DateFormatter()
            dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatterT.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatterT.date(from: expire)
            let expiry =  DatetoString(format: "MM-dd-yyyy", date: expireDate ?? Date())
            print("expiry",expiry)
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let today = dateFormatter.string(from: now)
            let TodayDate = formatter.date(from: today)
            print("expireDate----",expireDate ?? "")
            print("TodayDate-----",TodayDate ?? "")
            let monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
            print("monthly",monthly)
            if monthly == "monthly" {
                if TodayDate?.compare(expireDate ?? Date()) == .orderedDescending {
                    print("First Date is greater then second date")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedSame {
                    print("Both dates are same")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = false
                    btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedAscending {
                    print("First Date is smaller then second date")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                   self.btnSubsCription.isUserInteractionEnabled = false
                    btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
             }else{
                if expire == "" {
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + Showdate
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }else{
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }
            }
        }
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedSame {
            print("freeTrial Both dates are same")
            let expire = UserStoreSingleton.shared.expiry_date ?? ""
            print("expire",expire)
            let dateFormatterT = DateFormatter()
            dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatterT.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatterT.date(from: expire)
            let expiry =  DatetoString(format: "MM-dd-yyyy", date: expireDate ?? Date())
            print("expiry",expiry)
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let today = dateFormatter.string(from: now)
            let TodayDate = formatter.date(from: today)
            print("expireDate----",expireDate ?? "")
            print("TodayDate-----",TodayDate ?? "")
            let monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
            print("monthly",monthly)
            if monthly == "monthly" {
                if TodayDate?.compare(expireDate ?? Date()) == .orderedDescending {
                    print("First Date is greater then second date")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedSame {
                    print("Both dates are same")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = false
                    btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedAscending {
                    print("First Date is smaller then second date")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = false
                    btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
             }else{
                if expire == "" {
                    print("freeTrial Both dates are same")
                    expiryLbl.text = NSLocalizedString("Free Trial Expires On: ", comment: "") + Showdate
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }else{
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }
            }
        }
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedAscending {
            print("First Date is smaller then second date")
            let expire = UserStoreSingleton.shared.expiry_date ?? ""
            print("expire",expire)
            let dateFormatterT = DateFormatter()
            dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatterT.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatterT.date(from: expire)
            let expiry =  DatetoString(format: "MM-dd-yyyy", date: expireDate ?? Date())
            print("expiry",expiry)
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let today = dateFormatter.string(from: now)
            let TodayDate = formatter.date(from: today)
            print("expireDate----",expireDate ?? "")
            print("TodayDate-----",TodayDate ?? "")
            let monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
            print("monthly",monthly)
            if monthly == "monthly" {
                if TodayDate?.compare(expireDate ?? Date()) == .orderedDescending {
                    print("First Date is greater then second date")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedSame {
                    print("Both dates are same")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = false
                    btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedAscending {
                    print("First Date is smaller then second date")
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = false
                    btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
             }else{
                if expire == "" {
                    print("First Date is smaller then second date")
                    expiryLbl.text = NSLocalizedString("Free Trial Expires On: ", comment: "") + Showdate
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }else{
                    expiryLbl.text = NSLocalizedString("Monthly Subscription Expired On: ", comment: "") + (expiry)
                    expiryLbl.isHidden = false
                    self.btnSubsCription.isUserInteractionEnabled = true
                    btnSubsCription.setTitle(NSLocalizedString("Subscribe for $0.99 / month", comment: ""), for: .normal)
                }
            }
        }
    }
    func YearsubscriptionConfig(){
        let utcTime = UserStoreSingleton.shared.createdAt ?? ""
        print("utcTime",utcTime)
        let dateFormatterT = DateFormatter()
        dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatterT.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let startDate = dateFormatterT.date(from: utcTime)
        var dayComponent = DateComponents()
        dayComponent.day = 90
        let theCalendar = Calendar.current
        let firstDates = theCalendar.date(byAdding: dayComponent, to: startDate ?? Date())
        let Selecteddate =  DatetoString(format: "YYYY-MM-dd HH:mm:ss", date: firstDates ?? Date())
        let Showdate =  DatetoString(format: "MM-dd-yyyy", date: firstDates!)
        print("Showdate-------",Showdate)
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let today = dateFormatter.string(from: now)
        let FreeTodayDate = formatter.date(from: today)
        let FreeTrialDate = formatter.date(from: Selecteddate)
        print("FreeTrialDate----",FreeTrialDate ?? "")
        print("FreeTodayDate-----",FreeTodayDate ?? "")
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedDescending {
            print("First Date is greater then second date")
            let expire = UserStoreSingleton.shared.year_expiry_date ?? ""
            print("expire",expire)
            let dateFormatterT = DateFormatter()
            dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatterT.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatterT.date(from: expire)
            let expiry =  DatetoString(format: "MM-dd-yyyy", date: expireDate ?? Date())
            print("expiry",expiry)
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let today = dateFormatter.string(from: now)
            let TodayDate = formatter.date(from: today)
            print("expireDate----",expireDate ?? "")
            print("TodayDate-----",TodayDate ?? "")
            let yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
            print("yearly",yearly)
            if yearly == "yearly" {
                if TodayDate?.compare(expireDate ?? Date()) == .orderedDescending {
                    print("First Date is greater then second date")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedSame {
                    print("Both dates are same")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = false
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedAscending {
                    print("First Date is smaller then second date")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                   self.yearbtnSubsCription.isUserInteractionEnabled = false
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
             }else{
                if expire == "" {
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + Showdate
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }else{
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }
            }
        }
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedSame {
            print("freeTrial Both dates are same")
            let expire = UserStoreSingleton.shared.year_expiry_date ?? ""
            print("expire",expire)
            let dateFormatterT = DateFormatter()
            dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatterT.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatterT.date(from: expire)
            let expiry =  DatetoString(format: "MM-dd-yyyy", date: expireDate ?? Date())
            print("expiry",expiry)
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let today = dateFormatter.string(from: now)
            let TodayDate = formatter.date(from: today)
            print("expireDate----",expireDate ?? "")
            print("TodayDate-----",TodayDate ?? "")
            let yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
            print("yearly",yearly)
            if yearly == "yearly" {
                if TodayDate?.compare(expireDate ?? Date()) == .orderedDescending {
                    print("First Date is greater then second date")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedSame {
                    print("Both dates are same")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = false
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedAscending {
                    print("First Date is smaller then second date")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = false
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
             }else{
                if expire == "" {
                    print("freeTrial Both dates are same")
                    yearexpiryLbl.text = NSLocalizedString("Free Trial Expires On: ", comment: "") + Showdate
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }else{
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }
            }
        }
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedAscending {
            print("First Date is smaller then second date")
            let expire = UserStoreSingleton.shared.year_expiry_date ?? ""
            print("expire",expire)
            let dateFormatterT = DateFormatter()
            dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
            dateFormatterT.dateFormat = "yyyy-MM-dd"
            let expireDate = dateFormatterT.date(from: expire)
            let expiry =  DatetoString(format: "MM-dd-yyyy", date: expireDate ?? Date())
            print("expiry",expiry)
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            let today = dateFormatter.string(from: now)
            let TodayDate = formatter.date(from: today)
            print("expireDate----",expireDate ?? "")
            print("TodayDate-----",TodayDate ?? "")
            let yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
            print("yearly",yearly)
            if yearly == "yearly" {
                if TodayDate?.compare(expireDate ?? Date()) == .orderedDescending {
                    print("First Date is greater then second date")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedSame {
                    print("Both dates are same")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = false
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
                if TodayDate?.compare(expireDate ?? Date()) == .orderedAscending {
                    print("First Date is smaller then second date")
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = false
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                }
             }else{
                if expire == "" {
                    print("First Date is smaller then second date")
                    yearexpiryLbl.text = NSLocalizedString("Free Trial Expires On: ", comment: "") + Showdate
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }else{
                    yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expired On: ", comment: "") + (expiry)
                    yearexpiryLbl.isHidden = false
                    self.yearbtnSubsCription.isUserInteractionEnabled = true
                    yearbtnSubsCription.setTitle(NSLocalizedString("Subscribe for $7.99 / year", comment: ""), for: .normal)
                }
            }
        }
    }
    @IBAction func subscribe(_ sender: Any) {
        if productsArray.count > 0 {
        PKIAPHandler.shared.purchase(product: self.productsArray[0]) { (alert, product, transaction) in
            if alert.message == "You've successfully bought this purchase!" {
                let currentDate = Date()
                var dayComponent = DateComponents()
                dayComponent.day = 30
                let theCalendar = Calendar.current
                let firstDate = theCalendar.date(byAdding: dayComponent, to: currentDate)
                self.expiryLbl.text = NSLocalizedString("Monthly Subscription Expires On: ", comment: "") + (firstDate?.toString(dateFormat: "MM-dd-yyyy"))!
                self.expiryLbl.isHidden = false
                self.btnSubsCription.isUserInteractionEnabled = false
                self.btnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                DispatchQueue.main.async {
                   APPDELEGATE.receiptValidation()
                   }
                }
               print("Exceptional Excellence",alert.message)
            }
        }
    }
    @IBAction func yearSubscribe(_ sender: Any) {
        if productsArray.count > 0 {
        PKIAPHandler.shared.purchase(product: self.productsArray[1]) { (alert, product, transaction) in
            if alert.message == "You've successfully bought this purchase!" {
                let currentDate = Date()
                var dayComponent = DateComponents()
                dayComponent.day = 365
                let theCalendar = Calendar.current
                let firstDate = theCalendar.date(byAdding: dayComponent, to: currentDate)
                self.yearexpiryLbl.text = NSLocalizedString("Yearly Subscription Expires On: ", comment: "") + (firstDate?.toString(dateFormat: "MM-dd-yyyy"))!
                self.yearexpiryLbl.isHidden = false
                self.yearbtnSubsCription.isUserInteractionEnabled = false
                self.yearbtnSubsCription.setTitle(NSLocalizedString("Subscribed", comment: ""), for: .normal)
                DispatchQueue.main.async {
                   APPDELEGATE.receiptValidation()
                   }
                }
               print("Exceptional Excellence",alert.message)
            }
        }
    }
    func deleteAccount(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.deleteAccount(param: param, isAuthorization: true) { [self] (data) in
            defaultValues.removeObject(forKey: "userId")
            defaultValues.removeObject(forKey: "isAleadyLogin")
            UserStoreSingleton.shared.isLoggedIn = false
            UserStoreSingleton.shared.userType = ""
            
            let delegate = UIApplication.shared.delegate as? AppDelegate
            let vc = KMainStoryBoard.instantiateViewController(withIdentifier:"loginSide") as! UINavigationController
            delegate?.window?.rootViewController = vc
            delegate?.window?.makeKeyAndVisible()
        }
    }
    func LogOutApi(){
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.logOutApi(param: param, isAuthorization: true) { [self] (data) in
            defaultValues.removeObject(forKey: "userId")
            defaultValues.removeObject(forKey: "isAleadyLogin")
            UserStoreSingleton.shared.isLoggedIn = false
            UserStoreSingleton.shared.userType = ""
            
            let delegate = UIApplication.shared.delegate as? AppDelegate
            let vc = KMainStoryBoard.instantiateViewController(withIdentifier:"loginSide") as! UINavigationController
        
            delegate?.window?.rootViewController = vc
            delegate?.window?.makeKeyAndVisible()
        }
    }
}
extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

extension SettingVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:SettingsTableCell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
        
        cell.selectionStyle = .none
        let dict = arrSettings[indexPath.row]
        cell.img.image = UIImage.init(named:  dict["image"] ?? "")
        cell.lblTitle.text = dict["name"]
        cell.lblDescription.text = discrp[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserStoreSingleton.shared.is_Come_FromSocial == true {
            if indexPath.row == 0 {
                if #available(iOS 10.3, *) {
                  SKStoreReviewController.requestReview()
                }
            }
            else if indexPath.row == 1 {
                let objRef = self.storyboard?.instantiateViewController(withIdentifier: "notificationSettingVC") as! notificationSettingVC
                self.navigationController?.pushViewController(objRef, animated: true)
            }else if indexPath.row == 2 {
                if let url = URL(string: termsconditions), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }else if indexPath.row == 3 {
                if let url = URL(string: privacypolicy), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }else if indexPath.row == 4 {
                self.popupAlert(title: "From Me 2 U", message: "Are you sure, you want delete this account", actionTitles: ["Yes","No"], actions:[{action1 in
                    self.deleteAccount()
                },{action2 in
                    self.dismiss(animated: true, completion: nil)
                }, nil])
                
            }else if indexPath.row == 5 {
                if let url = URL(string: HelpUs), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }else if indexPath.row == 6 {
                self.popupAlert(title: "From Me 2 U", message: "Are you sure, you want logout this account", actionTitles: ["Yes","No"], actions:[{action1 in
                    self.LogOutApi()
                },{action2 in
                    self.dismiss(animated: true, completion: nil)
                }, nil])
              }
        }else{
        if indexPath.row == 0 {
            if #available(iOS 10.3, *) {
              SKStoreReviewController.requestReview()
            }
        }
        else if indexPath.row == 1 {
            let objRef = self.storyboard?.instantiateViewController(withIdentifier: "notificationSettingVC") as! notificationSettingVC
            self.navigationController?.pushViewController(objRef, animated: true)
            
        }else if indexPath.row == 2 {
            if let url = URL(string: termsconditions), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            
        }else if indexPath.row == 3 {
            if let url = URL(string: privacypolicy), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }else if indexPath.row == 4 {
            let objRef : ChangePasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(objRef, animated: true)
        }else if indexPath.row == 5 {
            self.popupAlert(title: "From Me 2 U", message: "Are you sure, you want delete this account", actionTitles: ["Yes","No"], actions:[{action1 in
                self.deleteAccount()
            },{action2 in
                self.dismiss(animated: true, completion: nil)
            }, nil])
            
        }else if indexPath.row == 6 {
            if let url = URL(string: HelpUs), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }else if indexPath.row == 7 {
            self.popupAlert(title: "From Me 2 U", message: "Are you sure, you want logout this account", actionTitles: ["Yes","No"], actions:[{action1 in
                self.LogOutApi()
            },{action2 in
                self.dismiss(animated: true, completion: nil)
            }, nil])
          }
       }
    }
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
           // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
           let layoutManager = NSLayoutManager()
           let textContainer = NSTextContainer(size: CGSize.zero)
           let textStorage = NSTextStorage(attributedString: label.attributedText!)

           // Configure layoutManager and textStorage
           layoutManager.addTextContainer(textContainer)
           textStorage.addLayoutManager(layoutManager)

           // Configure textContainer
           textContainer.lineFragmentPadding = 0.0
           textContainer.lineBreakMode = label.lineBreakMode
           textContainer.maximumNumberOfLines = label.numberOfLines
           let labelSize = label.bounds.size
           textContainer.size = labelSize

           // Find the tapped character location and compare it to the specified range
           let locationOfTouchInLabel = self.location(in: label)
           let textBoundingBox = layoutManager.usedRect(for: textContainer)
           let textContainerOffset = CGPoint(
               x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
               y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
           )
           let locationOfTouchInTextContainer = CGPoint(
               x: locationOfTouchInLabel.x - textContainerOffset.x,
               y: locationOfTouchInLabel.y - textContainerOffset.y
           )
           let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

           return NSLocationInRange(indexOfCharacter, targetRange)
       }
    
}



