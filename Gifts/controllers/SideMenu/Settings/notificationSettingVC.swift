//
//  MessageViewController.swift
//  Apeiron
//
// Created by Hardik on 18/01/22
//  Copyright © 2022 Hardik. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift
class notificationSettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var viewHeader:UIView!
    @IBOutlet var lblheader:UILabel!
    @IBOutlet var notificationTableView:UITableView!
    var index = 0
    var arrSettings:[[String:String]] = [["name":"All","type":"0"],
                                         ["name":"None","type":"1"],
                                         ["name":"from Giver","type":"2"],
                                         ["name":"from Receiver","type":"3"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.ProfileAction(notification:)), name: Notification.Name("notify"), object: nil)
    }
    @objc func ProfileAction(notification: Notification){
        self.navigationController?.popToRootViewController(animated: false)
    }
    @IBAction func action_Back_Tapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        index = Int(UserStoreSingleton.shared.notification ?? "") ?? 0
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        notificationTableView.rowHeight = 55
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        
    }
    //MARK:-Delegate & DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSettings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableCell", for: indexPath as IndexPath) as! notificationTableCell
        cell.selectionStyle = .none
        let dict = arrSettings[indexPath.row]
        cell.titleLbl.text = dict["name"]
        cell.selectionStyle = .none
        if index == indexPath.row {
            cell.btn.setImage(UIImage.init(named: "select"), for: .normal)
        }else{
            cell.btn.setImage(UIImage.init(named: "unselect"), for: .normal)
        }
        cell.btn.addTarget(self, action: #selector(btnPrsd), for: .touchUpInside)
        cell.btn.tag = indexPath.item
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    @objc func btnPrsd(sender: UIButton){
      print("sender.tag",sender.tag)
        index = sender.tag
        print("index",index)
        let param:[String:Any] = ["notification":index]
        OnboardViewModel.shared.updateNotification(param: param, isAuthorization: true) { [self] (data) in
            UserStoreSingleton.shared.notification = "\(index)"
            DisplayBanner.show(message: data.message)
            notificationTableView.reloadData()
        }
    }
}
//MARK:-messageTableCell
class notificationTableCell:UITableViewCell
{
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var btn: UIButton!
    override func awakeFromNib() {
        customView.layer.cornerRadius = 20
        customView.contentMode = .scaleAspectFill
    }
}
