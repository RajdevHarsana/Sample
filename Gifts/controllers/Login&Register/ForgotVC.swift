//
//  ForgotVC.swift
//  Gifts
//
//  Created by Macbook2012 on 22/02/21.
//
import UIKit
import SkyFloatingLabelTextField
//import ObjectMapper
class ForgotVC: BaseViewController {
    //MARK:- IBOutlets
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var viewBgEmail: UIView!
    @IBOutlet var tfEmail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBOutlet var btnSend: UIButton!
    //MARK:- Variable Declaration
    //var getRegisterModel:RegisterModel!
  //  var RegisterModelData:RegisterData!
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.addPadding(.both(20))
        if defaultValues.value(forKey: "isAleadyLogin") as? String == "1"{
            self.navigationController?.navigationBar.isHidden = true
        }
    }
   //MARK:- IBActions
    @IBAction func action_backBtnTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func action_sendBtnTapped(_ sender: UIButton){
        if emailTxt.text == ""{
            self.view.makeToast(NSLocalizedString(alertforgotEmailMeassge, comment: ""), duration: 3.0, position: .bottom)
        }else if Helper.shared.isValidEmail(candidate: emailTxt.text!){
            self.view.makeToast(NSLocalizedString(alertvaildEmailPhone, comment: ""), duration: 3.0, position: .bottom)
        }else{
            ForgotApi(getEmail:emailTxt.text!)
        }
    }
    
    //MARK:- Web Services
    func ForgotApi(getEmail:String) {

            if Helper.shared.isFieldEmpty(field: emailTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertValidEmail)
                return
            }
            if Helper.shared.isValidEmail(candidate: emailTxt.text ?? "") {
                DisplayBanner.show(message: ErrorMessages.alertValidEmail)
                return
            }
            
            if !Connectivity.isConnectedToInternet {
                DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
                return
            }
            
            let param:[String:Any] = [
                "email": emailTxt.text ?? ""
            ]
            
            OnboardViewModel.shared.userForgotPassword(param: param, isAuthorization: false) { [self] (data) in
                DisplayBanner.show(message: SuccessMessages.SentPasswordSuccessfully)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! loginVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
  
}
