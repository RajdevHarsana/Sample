//
//  SideMenuVC.swift
//  Gifts
//
//  Created by POSSIBILITY on 01/08/21.
//

import UIKit
//import ObjectMapper
import Toast_Swift
import Kingfisher
import LGSideMenuController
class SideMenuVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let menuNames = ["Company Profile","Settings"]
    let icons = ["search","favorite"]
//    var getLoginModel:LoginModel!
//    var LoginModelData:LoginData!
    var businessStatus = Int()
    var name  = ""
    var number = ""
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var menuLbl: UILabel!
    override func viewDidLoad(){
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "SidemenuCell", bundle: nil), forCellReuseIdentifier: "SidemenuCell")
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.versionLbl.text = NSLocalizedString("Version ", comment: "") + (appVersion ?? "1.0")
        self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2
        self.userImg.clipsToBounds = true
        self.loginBtn.setTitle(NSLocalizedString("Sign out", comment: ""), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateImg(notification:)), name: Notification.Name("updateImg"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLanguage(notification:)), name: Notification.Name("updateLanguage"), object: nil)
    }
    @objc func updateLanguage(notification: Notification){
        print("working-----")
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        self.versionLbl.text = NSLocalizedString("Version ", comment: "") + (appVersion ?? "1.0")
        self.loginBtn.setTitle(NSLocalizedString("Sign out", comment: ""), for: .normal)
        setNeedsStatusBarAppearanceUpdate()
        tableview.reloadData()
    }
    @objc func updateImg(notification: Notification){
        let image = defaultValues.string(forKey: "image") ?? ""
        if image == "" {
            self.userImg.image = UIImage.init(named: "userimg.png")
        }else{
            self.userImg.kf.indicatorType = .activity
            self.userImg.kf.setImage(with: URL(string:image))
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let image = defaultValues.string(forKey: "image") ?? ""
        if image == "" {
            self.userImg.image = UIImage.init(named: "userimg.png")
        }else{
            self.userImg.kf.indicatorType = .activity
            self.userImg.kf.setImage(with: URL(string:image))
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    @IBAction func action_Profile_Tapped(_ sender: Any) {
        self.sideMenuController?.hideRightView(sender: Any?(nilLiteral: ()))
        let viewController = KMainStoryBoard.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        let navigationController = sideMenuController!.rootViewController as! UINavigationController
        navigationController.pushViewController(viewController, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "SidemenuCell") as! SidemenuCell
        cell.lbl.text = NSLocalizedString(menuNames[indexPath.row], comment: "")
        cell.imgview.image = UIImage(named: icons[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        switch indexPath.row{
        case 0:
            self.sideMenuController?.hideRightView(sender: Any?(nilLiteral: ()))
            let viewController = KMainStoryBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            let navigationController = sideMenuController!.rootViewController as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        case 1:
            self.sideMenuController?.hideRightView(sender: Any?(nilLiteral: ()))
            let viewController = KMainStoryBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            let navigationController = sideMenuController!.rootViewController as! UINavigationController
            navigationController.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    @IBAction func action_login_Tapped(_ sender: Any) {
        signOutApi()
    }
    func signOutApi(){
        let alertController = UIAlertController(title: NSLocalizedString("Logout", comment: ""), message: NSLocalizedString("Are you sure you want to logout ?", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("Logout", comment: ""), style: UIAlertAction.Style.cancel) {
              UIAlertAction in
            let params: [String: Any] = [:]
            print(params);
//            WebService.shared.PostMethods(url:BaseViewController.LogoutUrl, parameters: params) { (response, error) in
//                self.getLoginModel = Mapper<LoginModel>().map(JSONObject: response)
//                defaultValues.set("", forKey: "accessToken")
//                defaultValues.set("", forKey: "userId")
//                defaultValues.set("", forKey: "name")
//                defaultValues.set("", forKey: "lastname")
//                defaultValues.set("", forKey: "email")
//                defaultValues.set("", forKey: "mobile")
//                defaultValues.set("", forKey: "countryCode")
//                defaultValues.set("", forKey: "deviceToken")
//                defaultValues.set("", forKey: "deviceType")
//                defaultValues.set("", forKey: "latitude")
//                defaultValues.set("", forKey: "longitude")
//                defaultValues.set("", forKey: "image")
//                defaultValues.setValue("", forKey: "country")
//                defaultValues.setValue("", forKey: "createdAt")
//                defaultValues.setValue("", forKey: "socialid")
//                defaultValues.setValue("0", forKey: "isAleadyLogin")
//                defaultValues.synchronize()            
//                APPDELEGATE.configureSideMenu()
//               }
          }
        okAction.setValue(UIColor.red, forKey: "titleTextColor")
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
              UIAlertAction in
              NSLog("Cancel Pressed")
          }
          alertController.addAction(okAction)
          alertController.addAction(cancelAction)
          self.present(alertController, animated: true, completion: nil)
       }
}



