//
//  ChangePasswordVC.swift
// Gifts
//
//  Created by POSSIBILITY on 13/08/21.
//
import UIKit
//import ObjectMapper
class ChangePasswordVC: BaseViewController,UITextFieldDelegate {
//    var getRegisterModel:RegisterModel!
  //  var RegisterModelData:RegisterData!
    @IBOutlet weak var current_pwsd_Txt: UITextField!
    @IBOutlet weak var new_pwsd_Txt: UITextField!
    @IBOutlet weak var confirm_pwsd_Txt: UITextField!
    @IBOutlet weak var eyebtn: UIButton!
    @IBOutlet weak var eyebtn1: UIButton!
    @IBOutlet weak var eyebtn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.tabBarController?.tabBar.isHidden = true
        current_pwsd_Txt.delegate = self
        current_pwsd_Txt.addPadding(.both(10))
        new_pwsd_Txt.delegate = self
        new_pwsd_Txt.addPadding(.both(19))
        confirm_pwsd_Txt.delegate = self
        confirm_pwsd_Txt.addPadding(.both(10))
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.ChangeAction(notification:)), name: Notification.Name("ChangePassword"), object: nil)
    }
    @objc func ChangeAction(notification: Notification){
        self.navigationController?.popToRootViewController(animated: false)
    }
    @IBAction func actionbackTaped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func action_Password_Tapped(_ sender: Any) {
        ChangePasswordAPI()
    }
    func ChangePasswordAPI() {
        if Helper.shared.isFieldEmpty(field: current_pwsd_Txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterCurrentPassword)
            return
        }
        if Helper.shared.isFieldEmpty(field: new_pwsd_Txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterNewPassword)
            return
        }
        if Helper.shared.isFieldEmpty(field: confirm_pwsd_Txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterConfirmPassword)
            return
        }
        if new_pwsd_Txt.text ?? "" != confirm_pwsd_Txt.text ?? "" {
            DisplayBanner.show(message: ErrorMessages.alertConfirmPasswordNotMatch)
            return
        }
        if !Helper.shared.isValidPassword(field: new_pwsd_Txt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.alertEnterValidPassword)
            return
        }
        
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        
        let param:[String:Any] = [
            "current_password": current_pwsd_Txt.text ?? "",
            "password" : new_pwsd_Txt.text ?? "",
            "password_confirmation" : confirm_pwsd_Txt.text ?? ""
        ]
        
        OnboardViewModel.shared.userChangePassword(param: param, isAuthorization: true) { [self] (data) in
         
            DisplayBanner.show(message: SuccessMessages.ChangePasswordSuccessfully)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    
    @IBAction func eyeAction(_ sender: Any) {
        eyebtn.setTitle("", for: .normal)
        current_pwsd_Txt.isSecureTextEntry.toggle()
           if current_pwsd_Txt.isSecureTextEntry {
               if let image = UIImage(systemName: "eye.fill") {
                   eyebtn.setImage(image, for: .normal)
               }
           } else {
               if let image = UIImage(systemName: "eye.slash.fill") {
                   eyebtn.setImage(image, for: .normal)
               }
           }
    }
    
    @IBAction func eyeAction1(_ sender: Any) {
        new_pwsd_Txt.isSecureTextEntry.toggle()
           if new_pwsd_Txt.isSecureTextEntry {
               if let image = UIImage(systemName: "eye.fill") {
                   eyebtn1.setImage(image, for: .normal)
               }
           } else {
               if let image = UIImage(systemName: "eye.slash.fill") {
                   eyebtn1.setImage(image, for: .normal)
               }
           }
    }
    
    @IBAction func eyeAction2(_ sender: Any) {
        confirm_pwsd_Txt.isSecureTextEntry.toggle()
           if confirm_pwsd_Txt.isSecureTextEntry {
               if let image = UIImage(systemName: "eye.fill") {
                   eyebtn2.setImage(image, for: .normal)
               }
           } else {
               if let image = UIImage(systemName: "eye.slash.fill") {
                   eyebtn2.setImage(image, for: .normal)
               }
           }
    }
}
