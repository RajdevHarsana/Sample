//
//  AddressVC.swift
//  Gifts
//
//  Created by Apple on 01/06/22.
//

import UIKit
import CoreLocation
import Designable
import GooglePlaces
import GoogleMaps
import Alamofire

class AddressVC: BaseViewController{
   
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confrimPawdTxt: UITextField!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnEye1: UIButton!
    @IBOutlet weak var txtfldFirstName: UITextField!
    @IBOutlet weak var txtfldLastName: UITextField!
    
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtfldCountryCode: UITextField!
    @IBOutlet weak var txtfldPhone: UITextField!
    
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var txtfldAddressLine1: UITextField!
    @IBOutlet weak var txtfldAddressLine2: UITextField!
    @IBOutlet weak var txtfldCity: UITextField!
    @IBOutlet weak var txtfldState: UITextField!
    @IBOutlet weak var txtflZipCode: UITextField!
    @IBOutlet weak var userImg: DesignableImageView!
    @IBOutlet weak var checkBox: UIButton!
    
    var terms = 0
    var imgUpload = false
    var userValue : String?
    var userTypeValue : Bool?
    var phoneNumber = ""
    var uploadImageURL = ""
    var userEmail : String?
    var userPassword : String?
    var userConfirmPassword : String?
    var latitude = Double()
    var longitude = Double()
    var locationManager : LocationManager?
    var locManager = CLLocationManager()
    var currentUserLocation: CLLocation!
    
    var textArray = [String]()
    var fontArray = [UIFont]()
    var colorArray = [UIColor]()
    var termsconditions = ""
    var privacypolicy = ""

    
    @IBOutlet weak var termsPrivancyLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       // showCurrentLocation()
        checkBox.setImage(UIImage.init(named: "checkBox"), for: .normal)
        emailTxt.addPadding(.both(20))
        passwordTxt.addPadding(.both(20))
        confrimPawdTxt.addPadding(.both(20))
        txtfldFirstName.addPadding(.both(20))
        txtfldLastName.addPadding(.both(20))
        SetUPUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
     //   showCurrentLocation()
    }
    
    //MARK: Custom Functions
    func SetUPUI() {
        
        textArray.append(NSLocalizedString("I understand the rules and risks I accept the ", comment: ""))
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
        self.termsPrivancyLbl.addGestureRecognizer(tapgesture)
        
        txtfldPhone.delegate = self
        if Global.objGlobalMethod.getSetCountryCode() {
            setSelectedCountry()
        }
        else {
            self.showAlert(Alert.alertTitle, Alert.countryCodeNotFound, Alert.buttonOK)
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
    func setSelectedCountry() {
        let flag = UserDefaults.standard.string(forKey: selectedCountryFlag)
        let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode) ?? ""
        self.btnCountryCode.setTitle("\(countryCode)", for: .normal)
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        txtfldPhone.text = format(with: "(XXX) XXX-XXXX", phone: newString)
          return false
    }
    
    //MARK:- Button Action
    @IBAction func checkTapped(_ sender: UIButton) {
        if (checkBox.currentImage == UIImage(named: "checkBox")) {
            self.terms = 1
            checkBox.setImage(UIImage.init(named: "selected"), for: .normal)
        }else{
            self.terms = 0
            checkBox.setImage(UIImage.init(named: "checkBox"), for: .normal)
        }
    }
    @IBAction func action_tearms_Tapped(_ sender: Any) {
        let objRef:tearmsVC = self.storyboard?.instantiateViewController(withIdentifier: "tearmsVC") as! tearmsVC
        self.navigationController?.pushViewController(objRef, animated: true)
    }
    @IBAction func eyeAction(_ sender: Any) {
        btnEye.setTitle("", for: .normal)
        passwordTxt.isSecureTextEntry.toggle()
           if passwordTxt.isSecureTextEntry {
               if let image = UIImage(systemName: "eye.fill") {
                   btnEye.setImage(image, for: .normal)
               }
           } else {
               if let image = UIImage(systemName: "eye.slash.fill") {
                   btnEye.setImage(image, for: .normal)
               }
           }
    }
    
    @IBAction func eyeAction1(_ sender: Any) {
        btnEye1.setTitle("", for: .normal)
        confrimPawdTxt.isSecureTextEntry.toggle()
           if confrimPawdTxt.isSecureTextEntry {
               if let image = UIImage(systemName: "eye.fill") {
                   btnEye1.setImage(image, for: .normal)
               }
           } else {
               if let image = UIImage(systemName: "eye.slash.fill") {
                   btnEye1.setImage(image, for: .normal)
               }
           }
    }
    @IBAction func action_login_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionSmsConfirmation(_ sender: Any) {
        
            let space = txtfldPhone.text?.filter { $0 != Character(" ")} ?? ""
            let hipen = space.filter { $0 != Character("-")}
            let assign = hipen.filter { $0 != Character("(")}
            let assigned = assign.filter { $0 != Character(")")}
            phoneNumber = assigned
    }
    
    @IBAction func btn_CountryCode(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CountryVC") as! CountryVC
        vc.objDelegate = self
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func actionConfirm(_ sender: Any) {

        addUploadApi()
    }
    //MARK:- GET USER PICKUP LOCATION
    @IBAction func txtPickUpLocation(_ sender: UITextField) {
        print("Start Typing")
        let acController = GMSAutocompleteViewController()
    
        acController.delegate = self
        self.present(acController, animated: true, completion: nil)
    }
    
    @IBAction func actionImgUpdate(_ sender: Any) {
        ImagePickerManager().pickImage(self){ [self] image,path  in
            print(path)
            userImg.image = image
            userImg.contentMode = .scaleAspectFill
            imgUpload = true
        }
    }
    func passLocation(){
        let param:[String:Any] = [
            "lat":UserStoreSingleton.shared.userlat ?? 0.0,
            "lng":UserStoreSingleton.shared.userLong ?? 0.0
        ]
        
        OnboardViewModel.shared.getDistanceApi(param: param, isAuthorization: true) { [self] (data) in
           
        }
    }
    func addUploadApi(){
      
        
        if imgUpload == true {
            if Helper.shared.isFieldEmpty(field: txtfldFirstName.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertFirstName)
                return
            }
            if Helper.shared.isFieldEmpty(field: txtfldLastName.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertLastName)
                return
            }

            
            if Helper.shared.isFieldEmpty(field: emailTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEmailEmpty)
                return
            }
            if Helper.shared.isValidEmail(candidate: emailTxt.text ?? ""){
                DisplayBanner.show(message: ErrorMessages.alertValidEmail)
                return
            }
            if Helper.shared.isFieldEmpty(field: passwordTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEnterPassword)
                return
            }
            if !Helper.shared.isValidPassword(field: passwordTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEnterValidPassword)
                return
            }
            if Helper.shared.isFieldEmpty(field: confrimPawdTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEnterConfirmPassword)
                return
            }
            if passwordTxt.text != confrimPawdTxt.text {
                DisplayBanner.show(message: ErrorMessages.alertConfirmPasswordNotMatch)
                return
            }
            if terms == 0 {
                DisplayBanner.show(message: ErrorMessages.termsConditions)
                return
            }
   
            let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode)

            if !Connectivity.isConnectedToInternet {
                DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
                return
            }
            let space = txtfldPhone.text?.filter { $0 != Character(" ")} ?? ""
            let hipen = space.filter { $0 != Character("-")}
            let assign = hipen.filter { $0 != Character("(")}
            let assigned = assign.filter { $0 != Character(")")}
            phoneNumber = assigned
            objHudShow()
            let param:[String:Any] = [
                "first_name": txtfldFirstName.text ?? "",
                "last_name" : txtfldLastName.text ?? "",
                "deviceType": deviceType,
                "deviceToken": Global.objGlobalMethod.firebaseToken,
                "country_code": countryCode!,
                "email":emailTxt.text ?? "",
                "password":passwordTxt.text ?? "",
                "mobile":phoneNumber,
                "latitude":latitude,
                "longitude":longitude
            ]
            
            print(param)
            

            AF.upload(multipartFormData: { multiPart in
               
                guard let imgData1 = (self.userImg.image)?.jpegData(compressionQuality: 0.5) else{return}
                    multiPart.append(imgData1, withName: "image",fileName: "image.png", mimeType: "image/jpg/png/jpeg")
                        for (key, value) in param {
                            multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                            
                        }
            },to:BaseViewController.SignUpUrl, method: .post, headers: nil).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    print(response)
                    Loader.stop()
                    self.objHudHide()
                    
                    let responsedata = response.data
                    do {
                        let responseModel = try JSONDecoder().decode(SignUpModel.self, from: responsedata!)
                        UserStoreSingleton.shared.userType = responseModel.data?.user_type
                        UserStoreSingleton.shared.userToken = responseModel.data?.access_token
                        UserStoreSingleton.shared.isLoggedIn = true
                        UserStoreSingleton.shared.userID = responseModel.data?.id
                        UserStoreSingleton.shared.profileImage = responseModel.data?.image
                        
                        let objRef:SuccessVC = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
                         self.navigationController?.pushViewController(objRef, animated: true)
                         } catch {
                               print(error)
                              // completed(.failure(.invalidData))
                         }

                    break
                case .failure( let error):
                    print(error.localizedDescription)
                    Loader.stop()
                    self.objHudHide()
                }
              })
            
        }else{
          
            if Helper.shared.isFieldEmpty(field: txtfldFirstName.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertFirstName)
                return
            }
            if Helper.shared.isFieldEmpty(field: txtfldLastName.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertLastName)
                return
            }

            
            if Helper.shared.isFieldEmpty(field: emailTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEmailEmpty)
                return
            }
            if Helper.shared.isValidEmail(candidate: emailTxt.text ?? ""){
                DisplayBanner.show(message: ErrorMessages.alertValidEmail)
                return
            }
            if Helper.shared.isFieldEmpty(field: passwordTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEnterPassword)
                return
            }
            if !Helper.shared.isValidPassword(field: passwordTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEnterValidPassword)
                return
            }
            if Helper.shared.isFieldEmpty(field: confrimPawdTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertEnterConfirmPassword)
                return
            }
            if passwordTxt.text != confrimPawdTxt.text {
                DisplayBanner.show(message: ErrorMessages.alertConfirmPasswordNotMatch)
                return
            }
            if terms == 0 {
                DisplayBanner.show(message: ErrorMessages.termsConditions)
                return
            }
            let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode)
           
            if !Connectivity.isConnectedToInternet {
                DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
                return
            }
            let space = txtfldPhone.text?.filter { $0 != Character(" ")} ?? ""
            let hipen = space.filter { $0 != Character("-")}
            let assign = hipen.filter { $0 != Character("(")}
            let assigned = assign.filter { $0 != Character(")")}
            phoneNumber = assigned
            objHudShow()
            let param:[String:Any] = [
                "first_name": txtfldFirstName.text ?? "",
                "last_name" : txtfldLastName.text ?? "",
                "deviceType": deviceType,
                "deviceToken": Global.objGlobalMethod.firebaseToken,
                "country_code": countryCode!,
                "email":emailTxt.text ?? "",
                "password":passwordTxt.text ?? "",
                "mobile":phoneNumber,
                "latitude":latitude,
                "longitude":longitude
            ]
            
            print(param)

            AF.upload(multipartFormData: { multiPart in
               
                guard let imgData1 = (UIImage.init(named: "userimg"))?.jpegData(compressionQuality: 0.5) else{return}
                    multiPart.append(imgData1, withName: "image",fileName: "image.png", mimeType: "image/jpg/png/jpeg")
                        for (key, value) in param {
                            multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                            
                        }
            },to:BaseViewController.SignUpUrl, method: .post, headers: nil).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    print(response)
                    Loader.stop()
                    self.objHudHide()
                    //self.passLocation()
                    let responsedata = response.data
                    do {
                        let responseModel = try JSONDecoder().decode(SignUpModel.self, from: responsedata!)
                        UserStoreSingleton.shared.userType = responseModel.data?.user_type
                        UserStoreSingleton.shared.userToken = responseModel.data?.access_token
                        UserStoreSingleton.shared.isLoggedIn = true
                        UserStoreSingleton.shared.userID = responseModel.data?.id
                        UserStoreSingleton.shared.profileImage = responseModel.data?.image
                        let objRef:SuccessVC = self.storyboard?.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
                         self.navigationController?.pushViewController(objRef, animated: true)
                         } catch {
                               print(error)
                              // completed(.failure(.invalidData))
                         }
                
                    break
                case .failure( let error):
                    print(error.localizedDescription)
                    Loader.stop()
                    self.objHudHide()
                }
              })
            
        }
        
    }
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        print(lat)
        print(lon)
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        print(ceo)
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        print(loc)
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            }
            print(placemarks as Any)
            let pm = placemarks! as [CLPlacemark]
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
               
                if pm.subLocality != nil {
                    addressString =  pm.thoroughfare ?? ""
                    self.txtfldAddressLine1.text = addressString
                }
                if pm.locality != nil {
                    addressString =  pm.name!
                    self.txtfldAddressLine2.text = addressString
                    
                }
                if pm.subLocality != nil {
                    addressString =  pm.locality ?? ""
                    self.txtfldCity.text = addressString
                }
                if pm.country != nil {
                    addressString = pm.country ?? ""
                    self.txtfldState.text = addressString

                }
                if pm.postalCode != nil {
                    addressString =  pm.postalCode ?? ""
                    self.txtflZipCode.text = addressString
                }
             
                print(addressString)

            }
        })
    }
}

//MARK: Country Selection Extension
extension AddressVC:  countryProtocol {
    func getCountry(data: CountryModel) {
        UserDefaults.standard.set("\(data.callingCode)", forKey: selectedCountryCode)
        UserDefaults.standard.set(data.countryFlag, forKey: selectedCountryFlag)
        setSelectedCountry()
    }
    
    func archiveCountryModel(countryData : CountryModel) -> Data {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: countryData, requiringSecureCoding: false)
            return data
        } catch {
            fatalError("Can't encode data: \(error)")
        }
    }
}

//MARK:- Textfile Delegate
extension AddressVC:  UITextFieldDelegate {

}
////MARK:- GMSAutocompleteViewControllerDelegate
extension AddressVC : GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let lat = place.coordinate.latitude
        let long = place.coordinate.longitude
        print("Place address: \(place.formattedAddress ?? "null")")
        print("Place lat: \(lat)")
        print("Place long: \(long)")
        latitude = lat
        longitude = long
        print("Place attributions: \(String(describing: place.attributions))")
        getAddressFromLatLon(pdblLatitude: lat, withLongitude: long)
        self.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        self.dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        self.dismiss(animated: true, completion: nil)
    }
}

