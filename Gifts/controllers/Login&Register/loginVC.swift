//
//  loginVC.swift
//  Gifts
//  Created by POSSIBILITY on 30/07/21.
import UIKit
import SkyFloatingLabelTextField
import Alamofire
//import ObjectMapper
import KeychainSwift
import AuthenticationServices
import GoogleSignIn
import FacebookCore
import FacebookLogin

class loginVC: BaseViewController , ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
 
    @IBOutlet weak var email_txt: UITextField!
    @IBOutlet weak var password_txt: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var appleBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var btneye: UIButton!
    @IBOutlet weak var checkBox: UIButton!
    var terms = 0
    var textArray = [String]()
    var fontArray = [UIFont]()
    var colorArray = [UIColor]()
    var termsconditions = ""
    var privacypolicy = ""
    @IBOutlet weak var termsPrivancyLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkBox.setImage(UIImage.init(named: "checkBox"), for: .normal)
        textArray.append(NSLocalizedString("By clicking this checkbox, Sign in with Apple, Sign in with Google or Sign in with Facebook, you agree to our ", comment: ""))
        textArray.append(NSLocalizedString("Terms and Conditions.", comment: ""))
        fontArray.append(Fonts.mediumFontWithSize(size: 15.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 15.0))
        fontArray.append(Fonts.mediumFontWithSize(size: 15.0))
        fontArray.append(Fonts.heavyFontWithSize(size: 15.0))
        colorArray.append(Colors.whiteColor)
        colorArray.append(Colors.whiteColor)
        colorArray.append(Colors.whiteColor)
        colorArray.append(Colors.blueColor)
        self.termsPrivancyLbl.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        self.termsPrivancyLbl.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.termsPrivacyLbl.addGestureRecognizer(tapgesture)
        appleBtn.layer.cornerRadius = 10
        googleBtn.layer.cornerRadius = 10
        facebookBtn.layer.cornerRadius = 10
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        versionLbl.text = NSLocalizedString("Version ", comment: "") + (appVersion ?? "1.0")
    }
    @IBAction func checkTapped(_ sender: UIButton) {
        if (checkBox.currentImage == UIImage(named: "checkBox")) {
            self.terms = 1
            checkBox.setImage(UIImage.init(named: "selected"), for: .normal)
        }else{
            self.terms = 0
            checkBox.setImage(UIImage.init(named: "checkBox"), for: .normal)
        }
    }
    //MARK:- tappedOnLabel
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.termsPrivancyLbl.text else { return }
        let Terms = (text as NSString).range(of: NSLocalizedString("Terms and Conditions.", comment: ""))
        if gesture.didTapAttributedTextInLabel(label: self.termsPrivancyLbl, inRange: Terms){
            print("Terms.")
            if let url = URL(string: "https://fromme2u.co/terms-of-service/") {
                UIApplication.shared.open(url)
            }
        }
    }
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
    @IBAction func eyeAction(_ sender: Any) {
        btneye.setTitle("", for: .normal)
        password_txt.isSecureTextEntry.toggle()
           if password_txt.isSecureTextEntry {
               if let image = UIImage(systemName: "eye.fill") {
                   btneye.setImage(image, for: .normal)
               }
           } else {
               if let image = UIImage(systemName: "eye.slash.fill") {
                   btneye.setImage(image, for: .normal)
               }
           }
    }
    @IBAction func actionLogin(_ sender: UIButton) {
        view.endEditing(true)
        //APPDELEGATE.configureSideMenu()
        SignInAPI()
    }
    
    @IBAction func actionSignup(_ sender: UIButton) {
        APPDELEGATE.isSocialLogin = false
        let objRef : AddressVC = self.storyboard?.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
        self.navigationController?.pushViewController(objRef, animated: true)
    }
    
    @IBAction func action_forgotTapped(_ sender: UIButton){
        APPDELEGATE.isSocialLogin = false
        let objRef:ForgotVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgotVC") as! ForgotVC
        self.navigationController?.pushViewController(objRef, animated: true)
    }
    
    @IBAction func action_backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func passLocation(){
        let param:[String:Any] = [
            "lat":UserStoreSingleton.shared.userlat ?? 0.0,
            "lng":UserStoreSingleton.shared.userLong ?? 0.0
        ]
        OnboardViewModel.shared.getDistanceApi(param: param, isAuthorization: true) { [self] (data) in
        }
    }
    // MARK:- social login action
    @IBAction func tapped_applelogin(_ sender: UIButton) {
        if terms == 0 {
            DisplayBanner.show(message: ErrorMessages.termsConditions)
            return
        }
        if #available(iOS 13.0, *)  {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: KeychainSwift().get("Justruck") ?? "") {
                (credentialState, error) in
                switch credentialState {
                case .authorized:
                    let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                                    ASAuthorizationPasswordProvider().createRequest()]
                    let authorizationController = ASAuthorizationController(authorizationRequests: requests)
                    authorizationController.delegate = self
                    authorizationController.presentationContextProvider = self
                    authorizationController.performRequests()
                    break
                case .revoked:
                    break
                case .notFound:
                    let request = appleIDProvider.createRequest()
                    request.requestedScopes = [.fullName, .email ]
                    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                    authorizationController.delegate = self
                    authorizationController.performRequests()
                default:
                    break
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Justruck" , message: "Comming Soon", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
   
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            if (appleIDCredential.fullName?.givenName != nil) {
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName?.givenName
                let familyName = appleIDCredential.fullName?.familyName
                let email = appleIDCredential.email
                KeychainSwift().set(userIdentifier, forKey: "userIdentifier")
                KeychainSwift().set(email ?? "", forKey: "email")
                KeychainSwift().set(fullName ?? "", forKey: "fullName")
                KeychainSwift().set(familyName ?? "", forKey: "familyName")
                setAppleApiData()
            }
            else{
                setAppleApiData()
            }
        }
    }
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: "") {  (credentialState, error) in
            switch credentialState {
            case .authorized:
                break
            case .revoked:
                break
            case .notFound: break
            default:
                break
            }
        }
    }
    func setAppleApiData(){
        let identifier = KeychainSwift().get("userIdentifierEZJobs") ?? ""
        var email = KeychainSwift().get("emailEZJobs")
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
          print(deviceID)
        if email == nil {
            email = identifier + "@apple.com"
        }else{
            
        }
        
        let firstName = KeychainSwift().get("familyNameEZJobs") ?? ""
        let lastName = KeychainSwift().get("fullNameEZJobs") ?? ""
        let appleParam: NSMutableDictionary = NSMutableDictionary.init()
        let name = firstName + " " + lastName
        appleParam.setValue(name, forKey: "name")
        appleParam.setValue(email, forKey: "email")
        appleParam.setValue(firstName , forKey: "first_name")
        appleParam.setValue(lastName , forKey: "last_name")
        appleParam.setValue(deviceID, forKey: "apple_id")
        appleParam.setValue("3", forKey: "type")
     //   appleParam.setValue(self.userSelect ?? "", forKey: "user_type")
        
        print(appleParam)
        self.socialLoginApi(params: appleParam)
        
       }
    
    var googleId = ""
    var googleFullname = ""
    var googleGivenName = ""
    var googleFamilyName = ""
    var googleEmail = ""
    
    @IBAction func tapped_googlelogin(_ sender: UIButton) {
        if terms == 0 {
            DisplayBanner.show(message: ErrorMessages.termsConditions)
            return
        }
        let signInConfig = GIDConfiguration.init(clientID: "945064398776-kj8ac73d36uciq0lrq9iah4fh9m60r7p.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
         
            if error == nil {
            guard let user = user else { return }
           
            let userId = user.userID
            let givenName = user.profile?.givenName ?? ""
            let familyName = user.profile?.familyName ?? ""
            let email1 = user.profile?.email ?? " "
          
                let GoogleParam: NSMutableDictionary = NSMutableDictionary.init()
                GoogleParam.setValue(givenName , forKey: "first_name")
                GoogleParam.setValue(familyName , forKey: "last_name")
                GoogleParam.setValue(email1, forKey: "email")
                GoogleParam.setValue(userId, forKey: "google_id")
                GoogleParam.setValue("2", forKey: "type")
                print(GoogleParam)
                self.socialLoginApi(params: GoogleParam)
            }
            else{
            print(error?.localizedDescription ?? "")
            }
        }
        }
    // MARK:- Social Login Functions ***********************************************
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    //MARK:- SOCIAL LOGIN API
    func socialLoginApi(params:NSMutableDictionary){
        
        params.setValue(Global.objGlobalMethod.firebaseToken, forKey: "device_token")
        params.setValue(deviceType, forKey: "device_type")
  
        print(params);

        OnboardViewModel.shared.userSocialLogin(param: params as! parameters, isAuthorization: false) { [self] (data) in
           // passLocation()
            UserStoreSingleton.shared.userType = data.data?.user_type
            UserStoreSingleton.shared.userToken = data.data?.access_token
            UserStoreSingleton.shared.isLoggedIn = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UserStoreSingleton.shared.is_Come_FromSocial = true
                UserStoreSingleton.shared.userID = data.data?.id
                UserStoreSingleton.shared.profileImage = data.data?.image
                UserStoreSingleton.shared.notification = data.data?.notification
                UserStoreSingleton.shared.createdAt = data.data?.created_at
                UserStoreSingleton.shared.expiry_date = data.expiry_date
                UserStoreSingleton.shared.subscription_type = data.subscription_type
                UserStoreSingleton.shared.year_expiry_date = data.year_expiry_date
                APPDELEGATE.configureTabbar()
             }
        }
    }
    
    //MARK:- FB
    @IBAction func tapped_fblogin(_ sender: UIButton) {
        if terms == 0 {
            DisplayBanner.show(message: ErrorMessages.termsConditions)
            return
        }
        loginWithFacebook(){ [self] (data, error) in
            if data != nil {
                socialLoginApi(params: data!)
            }
        }
    }
    //MARK:-  FACEBOOK LOGIN *********************************
    func loginWithFacebook(completion: @escaping (_ data:NSMutableDictionary? , _ error:Error?) -> Void)
    {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ .publicProfile,.email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
                completion(nil , nil)
                
            case .cancelled:
                print("User cancelled login.")
                completion(nil , nil)
                
            case .success(_, _, _):
                let graphReq : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "picture.width(512).height(512), name, email, first_name, last_name"])
                graphReq.start(completionHandler: { (connection, userInfo, error) in
                    if(userInfo != nil){
                        
                        let result = userInfo as! NSDictionary
                        let firstname = result.object(forKey: "first_name")
                        let lastname = result.object(forKey: "last_name")
                        let email = result.object(forKey: "email")
                        let id =  result.object(forKey: "id") as! String
                        
                        let params: NSMutableDictionary = NSMutableDictionary.init()
                        
                        params.setValue(firstname , forKey: "first_name")
                        params.setValue(lastname , forKey: "last_name")
                        params.setValue(email, forKey: "email")
                        params.setValue(id, forKey: "facebook_id")
                        params.setValue("1", forKey: "type")
//                        params.setValue(self.userSelect ?? "", forKey: "user_type")
                        print(params)
                      completion(params  , nil)
                        }
                    else {
                        completion(nil,nil)
                    }
                })
            }
        }
    }
}
