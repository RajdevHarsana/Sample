//  InfoVC.swift
// Gifts
//  Created by POSSIBILITY on 30/07/21.
import UIKit
import SkyFloatingLabelTextField
import Alamofire

class SignUpVC: BaseViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confrimPawdTxt: UITextField!
    @IBOutlet weak var btnEye: UIButton!
    @IBOutlet weak var btnEye1: UIButton!

    var terms = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.addPadding(.both(20))
        passwordTxt.addPadding(.both(20))
        confrimPawdTxt.addPadding(.both(20))
    }
    @objc func action_ShowHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxt.isSecureTextEntry = (sender.isSelected) ? true : false
    }
    @objc func action_confrimShowHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confrimPawdTxt.isSecureTextEntry = (sender.isSelected) ? true : false
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
    @IBAction func continueBtnTapped(_ sender: UIButton) {
        view.endEditing(true)
       SignUpAPI()
    }
    @IBAction func action_login_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
 
