//
//  tearmsVC.swift
//  TallyBook
//
//  Created by Apple on 04/03/22.
//

import UIKit
import Toast_Swift
import Kingfisher
import WebKit
class tearmsVC: BaseViewController {
    //MARK:- IBOutlets
    @IBOutlet weak var termsLbl: UILabel!
    @IBOutlet weak var webView: WKWebView!
    var TermsModelData:TermsModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.layer.cornerRadius = 10
        self.webView.layer.masksToBounds = true
        getTermsApi()
    }
   //MARK:- IBActions
    @IBAction func action_backBtnTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func loadHTMLStringImage(string: String?)  {
        self.webView.loadHTMLString(string ?? "", baseURL: nil)
    }
    //MARK:- WEBSERVICES METHODS ************************
    func getTermsApi(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = [:]
        OnboardViewModel.shared.GetTermsList(param: param, isAuthorization: true) { [self] (data) in
            print("data--------",data.data ?? "")
            let fontName =  "Poppins-Regular"
                let fontSize = 40
                let fontSetting = "<span style=\"font-family: \(fontName);font-size: \(fontSize)\"</span>"
               if data.data != nil {
                   self.webView.loadHTMLString( fontSetting + (data.data?.terms_conditions)!, baseURL: nil)
               }
           // self.loadHTMLStringImage(string: data.data?.terms_conditions ?? "")
        }
    }
}
