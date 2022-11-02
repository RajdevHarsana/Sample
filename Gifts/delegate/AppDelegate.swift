//
//  AppDelegate.swift
//  Gifts
//
//  Created by Apple on 02/04/21.
//
import UIKit
import GoogleSignIn
import LGSideMenuController
import IQKeyboardManagerSwift
import CoreLocation
import UserNotifications
import FirebaseMessaging
import Stripe
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import FBSDKCoreKit
import Firebase
import StoreKit
//import GoogleMobileAds
// GADFullScreenContentDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
    internal let kMapsAPIKey = "AIzaSyBq16ekrXE3LHeDIwu3KDk0O9s-rMjZpqc"
    var gcmMessageIDKey = "gcm.message_id"
    var locationManager = CLLocationManager()
    var LocationFunc =  false
    var isLocationFetched = false
    var activePlan = NSMutableArray()
    var window : UIWindow?
    var sideMenuViewController = SideMenuVC()
    var sectorNum = String()
    var isSocialLogin = false
    var fromNotification = false
    var APN_NotificatioData : NSDictionary?
    var expiry_date = ""
    var transaction_id = ""
    var subscription_type = ""
    var chatType = 0
    var notificationDict: NSDictionary = [:]

 //   var appOpenAd: GADAppOpenAd?
    var loadTime = Date()
    
    static var appDelegate: AppDelegate? = nil
       
    class func sharedInstance() -> AppDelegate {
        if appDelegate == nil {
         appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        }
        return appDelegate!
    }

//// 8-Aug-2022
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setKeyboard()
        configureTabbar()
        GMSPlacesClient.provideAPIKey(kMapsAPIKey)
        GMSServices.provideAPIKey(kMapsAPIKey)
        determineMyCurrentLocation()
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
        )
        FirebaseApp.configure()
        registerForPushUsingFCM(application)
        receiptValidation()
      //  GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
//    func requestAppOpenAd() {
//        let request = GADRequest()
//        GADAppOpenAd.load(withAdUnitID: APIs.OpenAdds,
//                          request: request,
//                          orientation: UIInterfaceOrientation.portrait,
//                          completionHandler: { (appOpenAdIn, _) in
//                            self.appOpenAd = appOpenAdIn
//                            self.appOpenAd?.fullScreenContentDelegate = self
//                            self.loadTime = Date()
//                            print("Ad is ready")
//                          })
//    }
//    func tryToPresentAd() {
//        if let gOpenAd = self.appOpenAd, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
//            gOpenAd.present(fromRootViewController:(UIApplication.shared.windows.first?.rootViewController)!)
//        } else {
//            self.requestAppOpenAd()
//        }
//    }
//    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
//        requestAppOpenAd()
//    }
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        requestAppOpenAd()
//    }
    func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
        let now = Date()
        let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
        let secondsPerHour = 3600.0
        let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        return intervalInHours < Double(thresholdN)
    }
    func setKeyboard(){
        IQKeyboardManager.shared.enable = true
    }
    func applicationWillResignActive(_ application: UIApplication) {
        print("1")
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("2")
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("3")
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("4")
//        if UserStoreSingleton.shared.isLoggedIn == true {
//            let monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
//            let yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
//            if monthly == "monthly" || yearly == "yearly" {
//            }else{
//               self.tryToPresentAd()
//            }
//        }
    }
    func applicationWillTerminate(_ application: UIApplication) {
        print("5")
    }
    func getExpirationDateFromResponse(_ jsonResponse: NSDictionary) -> NSDictionary? {
       if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
               let lastReceipt = receiptInfo.lastObject as! NSDictionary
              return lastReceipt
           }else {
           return nil
       }
   }
   func receiptValidation() {

       let receiptFileURL = Bundle.main.appStoreReceiptURL
       print("receiptFileURL",receiptFileURL ?? "")
       let receiptData = try? Data(contentsOf: receiptFileURL!)
       let recieptString = receiptData?.base64EncodedString(options: .endLineWithCarriageReturn)
       let jsonDict = ["receipt-data" : recieptString ?? "", "password" : BaseViewController.StoreKitPassword, "exclude-old-transactions" : true] as [String : Any]
       do {
           let requestData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
           let storeURL = URL(string: BaseViewController.verifyReceiptURL)!
           var storeRequest = URLRequest(url: storeURL)
           storeRequest.httpMethod = "POST"
           storeRequest.httpBody = requestData
           let session = URLSession(configuration: URLSessionConfiguration.default)
           let task = session.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) in
            do {
                if(data != nil){
                if let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                   print("Response 11 :",jsonResponse)
                    if let receiptInfo: NSArray = jsonResponse["pending_renewal_info"] as? NSArray {
                        self!.activePlan = receiptInfo as! NSMutableArray
                        for language in self!.activePlan {
                        let items = language as? NSMutableDictionary
                            print(items?.value(forKey: "product_id") as? String ?? "")
                            if items?.value(forKey: "product_id") as? String == BaseViewController.Monthly {
                                let monthly = items?.value(forKey: "expiration_intent") as? String ?? ""
                                print("monthly----",monthly)
                                if monthly == "1" || monthly == "2" || monthly == "3" || monthly == "4" || monthly == "5"{
                                   defaultValues.setValue("", forKey: "monthly")
                                  }else{
                                   defaultValues.setValue("monthly", forKey: "monthly")
                                }
                                self?.subscription_type = "1"
                            }
                            if items?.value(forKey: "product_id") as? String == BaseViewController.Yearly {
                                let yearly = items?.value(forKey: "expiration_intent") as? String ?? ""
                                print("yearly----",yearly)
                                if yearly == "1" || yearly == "2" || yearly == "3" || yearly == "4" || yearly == "5"{
                                   defaultValues.setValue("", forKey: "yearly")
                                  }else{
                                   defaultValues.setValue("yearly", forKey: "yearly")
                                }
                                self?.subscription_type = "2"
                            }
                         }
                     }
                     if let lastReceipts = self?.getExpirationDateFromResponse(jsonResponse) {
                         print("lastReceipts",lastReceipts)
                         let product_id = lastReceipts["product_id"] as? String
                         print("product_id",product_id)
                         if product_id == BaseViewController.Monthly {
                             let transaction_id = lastReceipts["transaction_id"] as? String
                             self?.transaction_id = transaction_id ?? ""
                             let expiresDate = lastReceipts["expires_date"] as! String
                             if let AppleExpiryDate = Formatter.customDate.date(from: expiresDate) {
                                 let ExpiryDate = DatetoString(format: "yyyy-MM-dd HH:mm:ss", date: AppleExpiryDate)
                                 self?.expiry_date = ExpiryDate
                                 let save_expiry_date = UserStoreSingleton.shared.expiry_date
                                 print("save_expiry_date",save_expiry_date ?? "")
                                 DispatchQueue.global(qos: .background).async {
                                   do{
                                       DispatchQueue.main.async { [self] in
                                           let userId = UserStoreSingleton.shared.userID ?? 0
                                           if userId == 0 {
                                           }else{
                                              self?.PaymentApi()
                                              }
                                          }
                                    }
                                 }
                                 UserStoreSingleton.shared.expiry_date = ExpiryDate
                                 print("expiry_date",UserStoreSingleton.shared.expiry_date ?? "")
                                }
                          }
                         if product_id == BaseViewController.Yearly {
                         let transaction_id = lastReceipts["transaction_id"] as? String
                         self?.transaction_id = transaction_id ?? ""
                         let expiresDate = lastReceipts["expires_date"] as! String
                         if let AppleExpiryDate = Formatter.customDate.date(from: expiresDate) {
                             let ExpiryDate = DatetoString(format: "yyyy-MM-dd HH:mm:ss", date: AppleExpiryDate)
                             self?.expiry_date = ExpiryDate
                             let save_expiry_date = UserStoreSingleton.shared.year_expiry_date
                             print("save_expiry_date",save_expiry_date ?? "")
                             DispatchQueue.global(qos: .background).async {
                               do{
                                   DispatchQueue.main.async { [self] in
                                       let userId = UserStoreSingleton.shared.userID ?? 0
                                       if userId == 0 {
                                       }else{
                                          self?.PaymentApi()
                                          }
                                      }
                                }
                             }
                             UserStoreSingleton.shared.year_expiry_date = ExpiryDate
                             print("year_expiry_date",UserStoreSingleton.shared.year_expiry_date ?? "")
                            }
                         }
                      }
                   }
                }else{
                    print("data is nil")
                }
               } catch let parseError {
                   print(parseError)
               }
           })
           task.resume()
          } catch let parseError {
           print(parseError)
        }
    }
    func PaymentApi(){
        print("done")
        var params: [String: Any] = [:]
        DispatchQueue.main.async {
            if self.subscription_type == "1" {
                params = [
                "transaction_id":self.transaction_id,
                "amount":"0.99",
                "subscription_type":self.subscription_type,
                "expiry_date":self.expiry_date,
                "year_expiry_date":self.expiry_date]
            }else{
                params = [
                "transaction_id":self.transaction_id,
                "amount":"9.99",
                "subscription_type":self.subscription_type,
                "expiry_date":self.expiry_date,
                "year_expiry_date":self.expiry_date]
            }
             print(params);
            OnboardViewModel.shared.addpaymentApi(param: params, isAuthorization: true) { [self] (data) in
                print(data);
            }
        }
    }
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool{
        let handle:Bool = ApplicationDelegate.shared.application(application, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
            return handle
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool{
        let handled: Bool = AppDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
            return handled
      }
}
extension Formatter {
    static let customDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
        return formatter
    }()
}
extension AppDelegate : UNUserNotificationCenterDelegate, MessagingDelegate {
    func registerForPushUsingFCM(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(fcmToken ?? "")")
        defaultValues.setValue(fcmToken!, forKey: "deviceToken")
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        Global.objGlobalMethod.firebaseToken = fcmToken ?? ""
        print("Firebase Token -->", Global.objGlobalMethod.firebaseToken)
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
        UserDefaults.standard.set(fcmToken, forKey: "FCM_Device_Token")
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([.alert,.sound])
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        let dict = userInfo as NSDictionary? as! [AnyHashable: Any]?
        let count  = dict?["badge"] ?? 0
        let value = "\(count)"
        UIApplication.shared.applicationIconBadgeNumber = Int(value) ?? 0
        print(dict ?? "")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateNotificationCount"), object: nil)
        let notificationType  = dict?["type"] ?? ""
        print("notificationType",notificationType)
        if notificationType as! String == "10" {
            let dicts  = dict?["Info"] ?? ""
             chatType = 1
             notificationDict = self.convertToDictionary(text: dicts as! String) as! NSDictionary
             let objRef = KMainStoryBoard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
             print("notificationDict----------",notificationDict)
             let chatId = notificationDict.value(forKey: "sender_id") as? Int ?? 0
             if chatId == UserStoreSingleton.shared.userID  {
                 let reciverId =  notificationDict.value(forKey: "receiver_id") as? Int ?? 0
                 let recivername = ""
                 let receiverPic = ""
                 let senderId = UserStoreSingleton.shared.userID ?? 0
                 let gift_id = notificationDict.value(forKey: "gift_id") ?? ""
                 let chat_id = "\(reciverId)" + "\(senderId)"
                 objRef.receiver_id = String(reciverId)
                 objRef.receiver_name = String(recivername)
                 objRef.receiver_Pic = String(receiverPic)
                 objRef.sender_id = String(senderId)
                 objRef.gift_id = gift_id as! String
                 objRef.chat_id = String(chat_id)
                self.window?.rootViewController = objRef
                self.window?.makeKeyAndVisible()
               }else{
                 let reciverId =  notificationDict.value(forKey: "sender_id") as? Int ?? 0
                 let recivername = ""
                 let receiverPic = ""
                 let senderId = UserStoreSingleton.shared.userID ?? 0
                 let gift_id = notificationDict.value(forKey: "gift_id") ?? ""
                 let chat_id = "\(reciverId)" + "\(senderId)"
                 objRef.receiver_id = String(reciverId)
                 objRef.receiver_name = String(recivername)
                 objRef.receiver_Pic = String(receiverPic)
                 objRef.sender_id = String(senderId)
                 objRef.gift_id = gift_id as! String
                 objRef.chat_id = String(chat_id)
                self.window?.rootViewController = objRef
                self.window?.makeKeyAndVisible()
               }
             }else{
                UIApplication.shared.applicationIconBadgeNumber = 0
                let delegate = UIApplication.shared.delegate as? AppDelegate
                let vc = KMainStoryBoard.instantiateViewController(withIdentifier: "MyTabbarVC") as! MyTabbarVC
                vc.selectedIndex = 2
                let nav = UINavigationController(rootViewController: vc)
                nav.setNavigationBarHidden(true, animated: true)
                delegate?.window?.rootViewController = nav
                self.window?.rootViewController = nav
                window?.makeKeyAndVisible()
                print(userInfo)
        }
        completionHandler(UIBackgroundFetchResult.newData)
     }
     func convertToDictionary(text: String) -> Any? {
         if let data = text.data(using: .utf8) {
             do {
                 return try JSONSerialization.jsonObject(with: data, options: []) as? Any
             } catch {
                 print(error.localizedDescription)
             }
         }
         return nil
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }
}
extension AppDelegate {
    // MARK: Methods
    func configureTabbar(){
        if UserStoreSingleton.shared.isLoggedIn == true {
         let delegate = UIApplication.shared.delegate as? AppDelegate
         let vc = KMainStoryBoard.instantiateViewController(withIdentifier: "MyTabbarVC") as! MyTabbarVC
         let nav = UINavigationController(rootViewController: vc)
         nav.setNavigationBarHidden(true, animated: true)
         delegate?.window?.rootViewController = nav
         self.window?.rootViewController = nav
         window?.makeKeyAndVisible()
        }else{
         let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
         let initialViewController = storyboard.instantiateViewController(withIdentifier:"loginSide") as! UINavigationController
         self.window?.rootViewController = initialViewController
         self.window?.makeKeyAndVisible()
        }
    }
}
extension AppDelegate{
  
    func determineMyCurrentLocation(){
        DispatchQueue.main.async {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self as CLLocationManagerDelegate
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            if  #available(iOS 14.0, *){
             self.locationManager.pausesLocationUpdatesAutomatically = false
            }
            self.locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled(){
                self.locationManager.startUpdatingLocation()
             }
            if #available(iOS 14.0, *) {
                if self.locationManager.authorizationStatus == .notDetermined {
                    self.locationManager.requestWhenInUseAuthorization()
                }
              }else{
            }
        }
    }
    func fetchCurrentLocation(_ application: UIApplication){
        if CLLocationManager.locationServicesEnabled() {
       switch CLLocationManager.authorizationStatus() {
       case .notDetermined:
        print("NotDetermined")
        self.determineMyCurrentLocation()
        break
       case .restricted, .denied:
           print("No access")
           let alert = UIAlertController(title: "Alert", message: "Please go to Settings > Gifts > Location > Enable Location While Using the App", preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
               guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                   return
               }
               if UIApplication.shared.canOpenURL(settingsUrl) {
                   UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                       print("Settings opened: \(success)")
                   })
               }
           }))
           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
           let vc = UIViewController()
           LocationFunc = true
           vc.present(alert, animated: true, completion: nil)
           break
        case .authorizedAlways, .authorizedWhenInUse:
           print("Access")
           break
       @unknown default:
        print("error")
       }
      }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        print(userLocation.coordinate)
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        UserStoreSingleton.shared.userlat = userLocation.coordinate.latitude
        UserStoreSingleton.shared.userLong = userLocation.coordinate.longitude
        manager.stopUpdatingLocation()
              DispatchQueue.main.async {
                if(!self.isLocationFetched) {
                    self.isLocationFetched = true
                    let latitude = String(format:"%.8f", userLocation.coordinate.latitude)
                    let longitude = String(format:"%.8f", userLocation.coordinate.longitude)
                    Singleton.sharedInstance.latitude = Double(latitude) ?? 0.0
                    Singleton.sharedInstance.longitude = Double(longitude) ?? 0.0
                    defaultValues.set("\(latitude)", forKey: "latitude")
                    defaultValues.set("\(longitude)", forKey: "longitude")
                    defaultValues.synchronize()
                    print("working--d--latitude---------",defaultValues.value(forKey: "latitude")!)
                    print("working--d--longitude---------",defaultValues.value(forKey: "longitude")!)
                    UserStoreSingleton.shared.userlat = userLocation.coordinate.latitude
                    UserStoreSingleton.shared.userLong = userLocation.coordinate.longitude
                    let locations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
                    self.getAddressFromCoordinates(location: locations)
                }
          }
    }
    func getAddressFromCoordinates(location: CLLocationCoordinate2D){
        let geocode = GMSGeocoder()
        geocode.reverseGeocodeCoordinate(location){
            (response,error) in
            if let CurrnetAddress = response?.firstResult(){
              let addressStr = CurrnetAddress.lines?.joined(separator: ",")
                switch CurrnetAddress.country! {
                case "India":
                   print(CurrnetAddress)
                case "United States":
                    print(CurrnetAddress)
                case "Australia":
                    print(CurrnetAddress)
                default:
                    print("defalt",addressStr as Any)
                }
                var place = ""
                if CurrnetAddress.locality != nil{
                    place = CurrnetAddress.locality ?? ""
                    defaultValues.set(addressStr!, forKey: "address")
                    defaultValues.synchronize()
                    Singleton.sharedInstance.address = addressStr!
                    print("add------------",defaultValues.value(forKey: "address") ?? "")
                }
                if CurrnetAddress.subLocality != nil{
                    place = CurrnetAddress.subLocality ?? ""
                    defaultValues.set(addressStr!, forKey: "address")
                    defaultValues.synchronize()
                    Singleton.sharedInstance.address = addressStr!
                    print("add------------",defaultValues.value(forKey: "address") ?? "")
                }
            }
        }
        self.locationManager.stopUpdatingLocation()
    }
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        let accuracyAuthorization = manager.accuracyAuthorization
        switch accuracyAuthorization {
        case .fullAccuracy:
            break
        case .reducedAccuracy:
            manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "ForDelivery")
            break
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Error \(error)")
    }
}
