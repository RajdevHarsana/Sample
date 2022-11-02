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
class MessageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var viewHeader:UIView!
    @IBOutlet var lblheader:UILabel!    
    @IBOutlet weak var LblNoMsg: UILabel!
    @IBOutlet var messageTableView:UITableView!
    
    var chatByData = [chatListData]() {
        didSet {
            messageTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("userID",UserStoreSingleton.shared.userID ?? "")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chatByUserAPI()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        messageTableView.rowHeight = 100
        messageTableView.delegate = self
        messageTableView.dataSource = self
  
    }
    //MARK:- search delegates ******************
    func chatByUserAPI(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["":""]
        OnboardViewModel.shared.GetChatUser(param: param, isAuthorization: true) { [self] (data) in
            print("data--------",data)
            chatByData = data.data ?? [chatListData]()
            if chatByData.count == 0 {
                messageTableView.isHidden = true
                LblNoMsg.isHidden = false
            }else{
                messageTableView.isHidden = false
                LblNoMsg.isHidden = true
            }
         
        }
    }
    //MARK: - Custom Access Methods
    @objc func imgTapped(_ gesture: UITapGestureRecognizer) {
  
    }
    @objc func btnBackTap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func btnHeaderTap(_ sender: UIButton){

    }
    //MARK:-Delegate & DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatByData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "msgTableCell", for: indexPath as IndexPath) as! messageTableCell
        let chatId = chatByData[indexPath.row].sender_detail?.id
        if chatId == UserStoreSingleton.shared.userID {
            let UserProfile = (chatByData[indexPath.row].receiver_detail?.image ?? "")
            cell.imgViewIcon.sd_setImage(with: URL(string:UserProfile), placeholderImage: UIImage(named: "userimg.png"))
            cell.lblName.text = chatByData[indexPath.row].receiver_detail?.name ?? ""
            if chatByData[indexPath.row].last_message?.message == "" {
            cell.lblMsg.text = "View image"
            }else{
            cell.lblMsg.text = chatByData[indexPath.row].last_message?.message
            }
            let jjj = chatByData[indexPath.row].created_at ?? ""
            let date = MessageVC.formatDat(date: jjj)
            print(date)
            cell.lblDate.text = date
            if "\(chatByData[indexPath.row].unseen_message_count ?? 0)" == "0" {
                cell.lblCount.isHidden = true
            }else{
            cell.lblCount.isHidden = false
            cell.lblCount.text = "\(chatByData[indexPath.row].unseen_message_count ?? 0)"
            }
        }else{
            let UserProfile = (chatByData[indexPath.row].sender_detail?.image ?? "")
            cell.imgViewIcon.sd_setImage(with: URL(string:UserProfile), placeholderImage: UIImage(named: "userimg.png"))
            let jjj = chatByData[indexPath.row].created_at ?? ""
            let date = MessageVC.formatDat(date: jjj)
            print(date)
            cell.lblDate.text = date
            cell.lblName.text = chatByData[indexPath.row].sender_detail?.name ?? ""
            if chatByData[indexPath.row].last_message?.message == "" {
            cell.lblMsg.text = "View image"
            }else{
            cell.lblMsg.text = chatByData[indexPath.row].last_message?.message
            }
            if "\(chatByData[indexPath.row].unseen_message_count ?? 0)" == "0" {
                cell.lblCount.isHidden = true
            }else{
            cell.lblCount.isHidden = false
            cell.lblCount.text = "\(chatByData[indexPath.row].unseen_message_count ?? 0)"
            }

        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatId = chatByData[indexPath.row].sender_detail?.id
        AppDelegate.sharedInstance().chatType = 0
        if chatId == UserStoreSingleton.shared.userID {
            let objRef : ChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            let reciverId = self.chatByData[indexPath.row].receiver_detail?.id ?? 0
            let recivername = self.chatByData[indexPath.row].receiver_detail?.name ?? ""
            let receiverPic = self.chatByData[indexPath.row].receiver_detail?.image ?? ""
            let gift_id = self.chatByData[indexPath.row].gift_id ?? 0
            let chat_id = self.chatByData[indexPath.row].last_message?.chat_id ?? 0
            objRef.receiver_id = String(reciverId)
            objRef.receiver_name = String(recivername)
            objRef.receiver_Pic = String(receiverPic)
            objRef.sender_id = "\(self.chatByData[indexPath.row].sender_detail?.id ?? 0)"
            objRef.gift_id = String(gift_id)
            objRef.chat_id = String(chat_id)
            self.navigationController?.pushViewController(objRef, animated: true)
        }else{
            let objRef : ChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
            let reciverId = self.chatByData[indexPath.row].sender_detail?.id ?? 0
            let recivername = self.chatByData[indexPath.row].sender_detail?.name ?? ""
            let receiverPic = self.chatByData[indexPath.row].sender_detail?.image ?? ""
            let gift_id = self.chatByData[indexPath.row].gift_id ?? 0
            let chat_id = self.chatByData[indexPath.row].last_message?.chat_id ?? 0
            objRef.receiver_id = String(reciverId)
            objRef.receiver_name = String(recivername)
            objRef.receiver_Pic = String(receiverPic)
            objRef.sender_id = "\(self.chatByData[indexPath.row].receiver_detail?.id ?? 0)"
            objRef.gift_id = String(gift_id)
            objRef.chat_id = String(chat_id)
            self.navigationController?.pushViewController(objRef, animated: true)
        }
    }
}
//MARK:-messageTableCell
class messageTableCell:UITableViewCell
{
    @IBOutlet var viewCell:UIView!
    @IBOutlet var imgViewIcon:UIImageView!
    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblMsg:UILabel!
    @IBOutlet var lblDate:UILabel!
    @IBOutlet weak var lblCount: UILabel!
    override func awakeFromNib() {
        
        imgViewIcon.layer.cornerRadius = imgViewIcon.frame.size.width/2
        imgViewIcon.contentMode = .scaleAspectFill
    
        lblCount?.layer.masksToBounds = true
        lblCount.layer.cornerRadius = lblCount.frame.size.width/2
        lblCount.textColor = UIColor.white
    }
    
}
extension MessageVC {
  
    class func formatDat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let convertedDate = dateFormatter.date(from: date)
        guard let date = convertedDate else {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, hh:mm a"
            let convertedDate: String = dateFormatter.string(from: currentDate)
            return convertedDate
        }
        dateFormatter.dateFormat = "EEEE, hh:mm a"
        dateFormatter.timeZone = .current
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
       }
}
