import UIKit
import SystemConfiguration
import NVActivityIndicatorView
import Toast_Swift
import Kingfisher

class BaseViewController : UIViewController {
    //MARK:-  live
//    static let BaseUrl = "http://192.168.1.84:8000/api/"
//    static let socketUrl = "http://192.168.1.84:3000"
    //MARK:-  local
    static let BaseUrl = "https://pro.fromme2u.co/api/"
    static let socketUrl = "http://3.138.251.58:3000"
    //MARK:- API LIST
    static let SignUpUrl = BaseUrl + "signup"
    static let LogInUrl = BaseUrl + "login"
    static let sociallogin = BaseUrl + "social-login"
    static let ForgotUrl = BaseUrl + "forgot-password"
    static let  UpdateProfileUrl = BaseUrl + "update-profile"
    static let ChangePasswordUrl = BaseUrl + "change-password"
    static let LogoutUrl = BaseUrl + "logout"
    static let BasicInfoUrl = BaseUrl + "app-basic-details"
    static let TermsUrl = BaseUrl + "terms-conditions"
    static let  ADD_New_Gift =  BaseUrl + "add-gift"
    static let Update_New_Gift = BaseUrl + "update-gift"
    static let Get_All_Gift = APIs.onBoardingBaseURL + "get-gift"
  
    static let appColor = #colorLiteral(red: 0.488576889, green: 0.1617230177, blue: 0.1462329626, alpha: 1)
    static let appDarkTextColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03921568627, alpha: 0.85)
    static let appLightTextColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
    
    //  IN-APP-PURCHANGE SETUP LIVE
    static let Monthly = "com.month"
    static let Yearly = "com.year"
    static let verifyReceiptURL = "https://buy.itunes.apple.com/verifyReceipt"
    static let StoreKitPassword = "562fd349dc744297a9fc34077e3bf020"
    
    //  IN-APP-PURCHANGE SETUP LOCAL
//      static let Monthly = "com.spearCard.monthly"
//      static let Yearly = "com.spearCard.yearly"
//      static let verifyReceiptURL = "https://sandbox.itunes.apple.com/verifyReceipt"
//      static let StoreKitPassword = "586228e993d84935b8680e40f8249b6a"
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:- Acticity Indicator
    var objNVHud = ActivityData(size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE, message: nil, messageFont: nil, type: NVActivityIndicatorType.ballRotateChase, color:appColor, padding: nil, displayTimeThreshold: NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD, minimumDisplayTime: NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME);
    
    func objHudShow(){
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(objNVHud,nil)
    }
    func objHudHide(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    //MARK:- Internet reachability Method
    func checkInternetConnection() -> Bool{
        if !self.connectedToNetwork() {
            let alertViewController = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Check internet connection and try again", comment: "") , preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { (action) -> Void in
            }
            alertViewController.addAction(okAction)
            self.present(alertViewController, animated: true, completion: nil)
            return false
        }
        else{
            return true
        }
    }
    func connectedToNetwork() -> Bool{
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1){
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags){
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    func  showConfirmationAlert(text:String , completion: @escaping(Bool) -> Void){
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.cancel, handler: { (_ ) in
            completion(true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { (_ ) in
            completion(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
