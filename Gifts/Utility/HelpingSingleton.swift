//
//  HelpingSingleton.swift
//  Stay Home
//
//  Created by GANESH on 02/06/20.
//  Copyright © 2020 Apptunix. All rights reserved.
//

import Foundation

import UIKit
//import Alamofire
//import SVProgressHUD
struct Helper
{
    static var shared = Helper()
    //App delegate
    
    // Mark: - Alert Message
    // =====================================
    // static func Alertmessage(title:String, message:String , vc:UIViewController?)
    //    {
    //        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    //        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
    //        alert.addAction(okAction)
    //
    //
    ////        if vc != nil
    ////        {
    ////            vc!.present(alert, animated: true, completion: nil)
    ////        }
    ////        else
    ////        {
    ////            if let appDelegate = UIApplication.shared.delegate as? AppDelegate
    ////            {
    ////                appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    ////            }
    ////        }
    //    }
    
    
    //    struct Alert {
    //        static func errorAlert(title: String, message: String?, cancelButton: Bool = false, completion: (() -> Void)? = nil) -> UIAlertController {
    //            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //            let actionOK = UIAlertAction(title: "OK", style: .default) {
    //                _ in
    //                guard let completion = completion else { return }
    //                completion()
    //            }
    //            alert.addAction(actionOK)
    //
    //            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    //            cancel.setValue(#colorLiteral(red: 0.08235294118, green: 0.6509803922, blue: 0.3411764706, alpha: 1), forKey: "titleTextColor")
    //            if cancelButton { alert.addAction(cancel) }
    //
    //            return alert
    //        }
    //
    //    }
    // =========== UIview only top edges cornerradius ================
    
    static func TopedgeviewCorner(viewoutlet:UIView, radius: CGFloat)
    {
        viewoutlet.clipsToBounds = true
        viewoutlet.layer.cornerRadius = radius
        viewoutlet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    static func BottemedgeviewCorner(viewoutlet:UIView)
    {
        viewoutlet.clipsToBounds = true
        viewoutlet.layer.cornerRadius = 15
        viewoutlet.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    static func viewCornerRadius(viewoutlet:UIView)
    {
        viewoutlet.clipsToBounds = true
        viewoutlet.layer.cornerRadius = 15
        viewoutlet.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    // ============  UITextView CornerRadius =======================
    
    static func TextviewcornerRadius(textviewoutlet:UITextView)
    {
        textviewoutlet.layer.borderWidth = 1
        textviewoutlet.layer.borderColor = UIColor.init(red: 175/255, green: 178/255, blue: 197/225, alpha: 0.2).cgColor
        textviewoutlet.layer.cornerRadius = 15
    }
    
    // Mark: - Valid Email or Not
    /*************************************************************/
    
    func isValidEmail(candidate: String) -> Bool {
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        if valid {
            valid = !candidate.contains("..")
        }
        return !valid
    }
    
    // Mark: - Field empty or not
    /*************************************************************/
    
    func isFieldEmpty(field: String) -> Bool {
        let trimmed = field.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count == 0
    }
    
    func isPhoneNumberValid(field: String) -> Bool {
        let phoneRegex = "^[0-9]{6,15}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: field)
        return !valid
    }
    
    func isValidPassword(field: String) -> Bool {
        let regex =  ("^(?=.*[0-9])(?=.*[A-Za-z]).{8,20}$")
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: field)
        if isMatched {
            return true
        }
        return false
    }
    
    func isValidEmailAddress(candidate: String) -> Bool {
       
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        if valid {
            valid = !candidate.contains("..")
        }
        return !valid
    }

}

