//
//  EditProfileVC.swift
//  Gifts
//
//  Created by POSSIBILITY on 13/08/21.
//

import UIKit
import UIKit
import SkyFloatingLabelTextField
import Alamofire
import BSImagePicker
import Photos
import Designable
import GooglePlaces
import GoogleMaps
import KMPlaceholderTextView

class EditProfileVC:BaseViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate {
  
  
    @IBOutlet weak var txtfldFirstName: UITextField!
    @IBOutlet weak var txtfldLastName: UITextField!
    
    @IBOutlet weak var editimg: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnCountryCode: UIButton!
    @IBOutlet weak var txtfldCountryCode: UITextField!
    @IBOutlet weak var txtfldPhone: UITextField!
    
    @IBOutlet weak var txtfldEmail: UITextField!
    @IBOutlet weak var txtfldAddressLine1: UITextField!
    @IBOutlet weak var txtfldAddressLine2: UITextField!
    @IBOutlet weak var txtfldCity: UITextField!
    @IBOutlet weak var txtfldState: UITextField!
    @IBOutlet weak var txtflZipCode: UITextField!
    @IBOutlet weak var userImg: DesignableImageView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    
    @IBOutlet weak var giftDescpt: KMPlaceholderTextView!
    
    var CountryCode = ""
    var phoneNumber = ""
    var imgUpload = false
    var locationManager : LocationManager?
    var locManager = CLLocationManager()
    var uploadImageURL = ""
    var isUpdateProfile = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProfile()
        txtfldFirstName.addPadding(.both(10))
        txtfldLastName.addPadding(.both(10))
        txtfldAddressLine1.addPadding(.both(10))
        txtfldAddressLine2.addPadding(.both(10))
        txtfldCity.addPadding(.both(10))
        txtfldState.addPadding(.both(10))
        txtflZipCode.addPadding(.both(10))
        txtfldEmail.addPadding(.both(10))
        SetUPUI()
       
        let image = defaultValues.string(forKey: "image") ?? ""
        if image == "" {
         self.userImg.image = UIImage.init(named: "userimg.png")
        }else{
           self.userImg.kf.indicatorType = .activity
           self.userImg.kf.setImage(with: URL(string:image))
        }
       
        if  UserStoreSingleton.shared.is_Come_FromSocial  == true {
            txtfldEmail.isUserInteractionEnabled = false
            editimg.isHidden = true
        }else{
            editimg.isHidden = false
            txtfldEmail.isUserInteractionEnabled = true
        }
      
    }
    
    //MARK: Custom Functions
    func SetUPUI() {
        txtfldPhone.delegate = self
        if Global.objGlobalMethod.getSetCountryCode() {
            setSelectedCountry()
        }
        else {
            self.showAlert(Alert.alertTitle, Alert.countryCodeNotFound, Alert.buttonOK)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceholder.isHidden = !textView.text.isEmpty
    }
    
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
        if giftDescpt.textColor == UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1.0) {
            lblPlaceholder.isHidden = true
            giftDescpt.text = ""
            giftDescpt.textColor = UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1.0)
        }
    }
    
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        if giftDescpt.text == "" {
            lblPlaceholder.isHidden = false
           // txtviewAbout.text = "About..."
            giftDescpt.textColor = UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1.0)
        }
    }
       
    override func viewWillAppear(_ animated: Bool) {
     
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
    
    @IBAction func actionbackTaped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    @IBAction func actionImgUpdate(_ sender: Any) {
        ImagePickerManager().pickImage(self){ [self] image,path  in
            print(path)
            DispatchQueue.main.async {
               self.userImg.image = image.resize(800, 800)
               self.imgUpload = true
             }
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
            let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode)
            if countryCode == "" || countryCode == nil {
                DisplayBanner.show(message: ErrorMessages.alertChooseCountryCode)
                return
            }
            if !Connectivity.isConnectedToInternet {
                DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
                return
            }
            let space = txtfldPhone.text?.filter { $0 != Character(" ")} ?? ""
            let hipen = space.filter { $0 != Character("-")}
            let assign = hipen.filter { $0 != Character("(")}
            let assigned = assign.filter { $0 != Character(")")}
            phoneNumber = assigned
            
            let param:[String:Any] = [
                "first_name": txtfldFirstName.text ?? "",
                "last_name" : txtfldLastName.text ?? "",
                "deviceType": deviceType,
                "deviceToken": Global.objGlobalMethod.firebaseToken,
                "city": txtfldCity.text ?? "",
                "state": txtfldState.text ?? "",
                "zip": txtflZipCode.text ?? "",
                "address1": txtfldAddressLine1.text ?? "",
                "country": txtfldCity.text ?? "",
                "country_code": countryCode!,
                "mobile":phoneNumber,
                "latitude":latitude,
                "longitude":longitude,
                "email":txtfldEmail.text ?? "",
                "description": giftDescpt.text ?? ""
            ]
            
            print("param",param)
            Loader.start()
            var header = HTTPHeaders()
            if let token =   UserStoreSingleton.shared.userToken {
                print("Access Token --",token)
                header = [
                    "authorization": "Bearer \(token)",
                    "Accept": "application/json"
                ]
            }
            else {
                DisplayBanner.show(message: "Token not accessible")
            }
            AF.upload(multipartFormData: { multiPart in
               
                guard let imgData1 = (self.userImg.image)?.jpegData(compressionQuality: 0.5) else{return}
                    multiPart.append(imgData1, withName: "image",fileName: "image.png", mimeType: "image/jpg/png/jpeg")
                        for (key, value) in param {
                            multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                            
                        }
            },to:BaseViewController.UpdateProfileUrl, method: .post, headers: header).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    print(response)
                    Loader.stop()
              
                    self.navigationController?.popViewController(animated: true)

                    break
                case .failure( let error):
                    print(error.localizedDescription)
                    Loader.stop()
                 
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
            let countryCode = UserDefaults.standard.string(forKey: selectedCountryCode)
            if countryCode == "" || countryCode == nil {
                DisplayBanner.show(message: ErrorMessages.alertChooseCountryCode)
                return
            }
            if !Connectivity.isConnectedToInternet {
                DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
                return
            }
            let space = txtfldPhone.text?.filter { $0 != Character(" ")} ?? ""
            let hipen = space.filter { $0 != Character("-")}
            let assign = hipen.filter { $0 != Character("(")}
            let assigned = assign.filter { $0 != Character(")")}
            phoneNumber = assigned
            
            let param:[String:Any] = [
                "first_name": txtfldFirstName.text ?? "",
                "last_name" : txtfldLastName.text ?? "",
                "deviceType": deviceType,
                "deviceToken": Global.objGlobalMethod.firebaseToken,
                "city": txtfldCity.text ?? "",
                "state": txtfldState.text ?? "",
                "zip": txtflZipCode.text ?? "",
                "address1": txtfldAddressLine1.text ?? "",
                "country": txtfldCity.text ?? "",
                "country_code": countryCode!,
                "mobile":phoneNumber,
                "latitude":latitude,
                "longitude":longitude,
                "email":txtfldEmail.text ?? "",
                "description": giftDescpt.text ?? ""
            ]
            
            print("param",param)
            Loader.start()
            var header = HTTPHeaders()
            if let token =    UserStoreSingleton.shared.userToken {
                print("Access Token --",token)
                header = [
                    "authorization": "Bearer \(token)",
                    "Accept": "application/json"
                ]
            }
            else {
                DisplayBanner.show(message: "Token not accessible")
            }
            AF.upload(multipartFormData: { multiPart in
                for (key, value) in param {
                    multiPart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            },to:BaseViewController.UpdateProfileUrl, method: .post, headers: header).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    print(response)
                    Loader.stop()
                    self.navigationController?.popViewController(animated: true)
                    break
                case .failure( let error):
                    print(error.localizedDescription)
                    Loader.stop()
                 
                }
            })
        }
    }
}
//MARK: Country Selection Extension
extension EditProfileVC:  countryProtocol {
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
