//
//  ChatViewController.swift
//  Apeiron
//
// Created by Hardik on 18/01/22
//  Copyright © 2022 Hardik. All rights reserved.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift
import SocketIO
import SDWebImage
import GSImageViewerController

class ChatViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let manager = SocketManager(socketURL: URL(string:BaseViewController.socketUrl)! ,config: [.log(true), .compress])
    var gift_id = String()
    var sender_id = String()
    var receiver_id = String()
    var chatId = ""
    var receiver_name = ""
    var receiver_Pic = ""
    var chat_id = ""
    var message_id = Int()
    var socket:SocketIOClient?
  
    var Received:String = ""
    var Send:String = ""
    var type = String()
    var seen = String()
    var baground = String()

    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var tbl_Chat: UITableView!
    @IBOutlet weak var view_Send: UIView!
    @IBOutlet weak var view_Send_Parent: UIView!

    var chatByData = [chatListData]() {
        didSet {
            tbl_Chat.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        tbl_Chat.delegate = self
        tbl_Chat.dataSource = self
        txtMessage.delegate = self
        self.socket = manager.defaultSocket
        self.initializeSocket()
        self.Send = sender_id + receiver_id
        self.chatId = receiver_id + sender_id
        self.Received = "receivedMessage"
        self.initRecived(request:self.Received)
        self.initSend(request: self.Send)
        self.SeenMessage(request: "acknowledge")
       // WebService.shared.objHudShow()
        chatByIDAPI()
        configureUI()
        configureTableView()
    }
    func configureUI(){
        
        view_Send.layer.cornerRadius = view_Send.frame.height / 2
        view_Send.layer.borderWidth = 0.5
        view_Send.layer.borderColor = UIColor.lightGray.cgColor
    }

    func configureTableView() {

        tbl_Chat.delegate = self
        tbl_Chat.dataSource = self
        self.tbl_Chat.register(UINib.init(nibName: "ReciverChatCell", bundle: .main), forCellReuseIdentifier: "ReciverChatCell")
        self.tbl_Chat.register(UINib.init(nibName: "ReciverImageCell", bundle: .main), forCellReuseIdentifier: "ReciverImageCell")
        self.tbl_Chat.register(UINib.init(nibName: "SenderChatCell", bundle: .main), forCellReuseIdentifier: "SenderChatCell")
        self.tbl_Chat.register(UINib.init(nibName: "SenderImageCell", bundle: .main), forCellReuseIdentifier: "SenderImageCell")
        self.tbl_Chat.reloadData()
    }
    //MARK:- search delegates ******************
    func chatByIDAPI(){
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = ["user_id":receiver_id,"gift_id":gift_id]
        OnboardViewModel.shared.GetChatList(param: param, isAuthorization: true) { [self] (data) in
           // print("data--------",data)
            chatByData = data.data ?? [chatListData]()
            self.chatByData.reverse()
            if self.chatByData.count > 0 {
            DispatchQueue.main.async {
                let indexPath = IndexPath(row: self.chatByData.count-1, section: 0)
                self.tbl_Chat.scrollToRow(at: indexPath, at: .top, animated: false)
                }
            }
            self.tbl_Chat.reloadData()
        }
    }
    func initializeSocket(){
        self.socket?.on("connect"){ data, ack in
            print("socket connected")
            self.Seen()
            self.socket?.emit("join",self.Send)
        }
        self.socket?.on("disconnect"){ data, ack in
            print("socket disconnect")
        }
        self.socket?.on("connect_error"){ data, ack in
            print("socket connect_error")
        }
        self.socket?.on("connect_timeout"){ data, ack in
            print("socket connect_timeout")
        }
        self.socket?.connect()
    }
    func minimumDate() -> Int {
        let curerntdate = Date()
        let selectdateinlong = curerntdate.timeIntervalSince1970
        let longDateObj1 = selectdateinlong*1000
        let longDate = Int(longDateObj1)
        return longDate
    }
    func requestSocketAPI() {
        let perms:[String:Any]  = [
            "gift_id": gift_id,
            "sender_id": sender_id,
            "sent_by": sender_id,
            "is_seen": "0",
            "receiver_id": receiver_id,
            "chatId": self.chatId,
            "type":"text",
            "message":self.txtMessage.text!
        ]
        print("perms",perms)
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted /* Pass 0 if you don't care about the readability of the generated string */)
        } catch {
            print(error.localizedDescription)
        }
           var jsonString: String? = nil
            if let jsonData = jsonData {
            jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
           self.socket?.emit("sendMessage", perms)
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted)
                let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
               
                if let dictFromJSON = decoded as? [String:Any] {
                    print("dictFromJSON",dictFromJSON)
                    chatByData.append(chatListData(created_at: "", id: 0, gift_id: 0, message: self.txtMessage.text!, sent_by: Int(sender_id), is_seen: "", last_message: last_message(chat_id: 0, createdAt: "", file: "", fileExtension: "", fivarype: "", id: 0, isSeen: "", message: "", sent_by: 0, sender_detail: sender_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), type: "", updatedAt: ""), sent_by_detail: sent_by_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), receiver_detail: receiver_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), receiverId: 0, sender_detail: sender_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), sender_id: 0, updatedAt: "", unseen_message_count: 0))
                    self.txtMessage.text = ""
                    self.txtMessage.resignFirstResponder()
                    self.tbl_Chat.reloadData()
                    if self.chatByData.count > 0 {
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(row: self.chatByData.count-1, section: 0)
                        self.tbl_Chat.scrollToRow(at: indexPath, at: .top, animated: false)
                        }
                   }
                }
            } catch {
            print(error.localizedDescription)
           }
        }
    }
    func initSend(request:String) {
        self.socket?.on(Send) { (dataArray, ack) in
        print("message send: \(dataArray)")
        }
    }
    func initRecived(request:String) {
    
        let perms:[String:Any]  = [:]
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted /* Pass 0 if you don't care about the readability of the generated string */)
        } catch {
            print(error.localizedDescription)
        }
        var jsonString: String? = nil
        if let jsonData = jsonData {
            jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
            self.socket?.on(Received) { [self] (dataArray, ack) in
            print("message received: \(dataArray)")
                do {
                    let response = dataArray[0]
                    let dict  = response as! NSDictionary
                    let id = dict.value(forKey: "id") as? Int
                    message_id = id ?? 0
                    let gift_id = dict.value(forKey: "gift_id") as? Int
                    let last_messages = dict.value(forKey: "last_message") as? NSDictionary
                    let sent_by_details = last_messages?.value(forKey: "sent_by_detail") as? NSDictionary
                    let name = sent_by_details?.value(forKey: "name") as? String
                    let image = sent_by_details?.value(forKey: "image") as? String
                    let created_at = dict.value(forKey: "created_at") as? String
                    let type = last_messages?.value(forKey: "type") as? String
                    let file = last_messages?.value(forKey: "file") as? String
                    chatByData.append(chatListData(created_at: created_at, id: id, gift_id: gift_id, message: last_messages?.value(forKey: "message") as? String ?? "", sent_by: last_messages?.value(forKey: "sent_by") as? Int ?? 0, is_seen: "0", type: type, file_type: "image", last_message: last_message(chat_id: 0, createdAt: "", file: "", fileExtension: "", fivarype: "", id: 0, isSeen: "", message: "", sent_by: 0, sender_detail: sender_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), type: "", updatedAt: ""), sent_by_detail: sent_by_detail(id: 0, name: name, first_name: "", last_name: "", email: "", image: image), receiver_detail: receiver_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), receiverId: 0, sender_detail: sender_detail(id: 0, name: UserStoreSingleton.shared.name, first_name: "", last_name: "", email: "", image: UserStoreSingleton.shared.profileImage), sender_id: 0, updatedAt: "", unseen_message_count: 0, file: file))
                    self.Seen()
                    self.tbl_Chat.reloadData()
                    if self.chatByData.count > 0 {
                    DispatchQueue.main.async {
                           let indexPath = IndexPath(row: self.chatByData.count-1, section: 0)
                           self.tbl_Chat.scrollToRow(at: indexPath, at: .top, animated: false)
                          }
                       }
                   } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    func SeenMessage(request:String) {
        
        let perms:[String:Any]  = [:]
        print(perms)
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted /* Pass 0 if you don't care about the readability of the generated string */)
        } catch {
            print(error.localizedDescription)
        }
        var jsonString: String? = nil
        if let jsonData = jsonData {
            jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
            self.socket?.on("acknowledge") { (dataArray, ack) in
                print("USER seen...: \(dataArray)")
                do {
                    let response = dataArray[0]
                    let dict  = response as! NSDictionary
                    let isSeen = dict.value(forKey: "is_seen")as! String
                    print("isSeen",isSeen)
                    if (isSeen == "0") {
                        for index in 0..<self.chatByData.count {
                            self.chatByData[index].is_seen = "1"
                        }
                        self.tbl_Chat.reloadData()
                        if self.chatByData.count > 0 {
                            DispatchQueue.main.async {
                                let indexPath = IndexPath(row: self.chatByData.count-1, section: 0)
                                self.tbl_Chat.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }else{
                    }
                }
            }
        }
    }
    func Seen () {
        let sender_id1 = (sender_id as NSString).integerValue
        let receiver_id1 = (receiver_id as NSString).integerValue
        let perms:[String:Any]  = ["message_id":message_id,"sender_id":sender_id1,"receiver_id":receiver_id1]
        print("seen----perms",perms)
        var jsonData: Data? = nil
        do {
            jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted /* Pass 0 if you don't care about the readability of the generated string */)
        } catch {
            print(error.localizedDescription)
        }
        var jsonString: String? = nil
        if let jsonData = jsonData {
            jsonString = String(data: jsonData, encoding: .utf8)
            print(jsonString!)
            self.socket?.emit("message_seen", jsonString!)
        }
    }
    // MARK:- Listening From Socket for incoming meessages
    func convertToDictionary(text: String) -> [String: Any]? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    @IBAction func actionSendMessage(_ sender: Any) {
        if (txtMessage.text == "Type a message"){
            DisplayBanner.show(message: "please enter message")
            return
            
        }else if (txtMessage.text == ""){
            DisplayBanner.show(message: "please enter message")
            return
        }else{
            requestSocketAPI()
            txtMessage.text = ""
          }
    }
    // MARK: - TableView Delegate, Datasource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return chatByData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let type:Int = chatByData[indexPath.row].sent_by ?? 0
        if type == UserStoreSingleton.shared.userID {
            if chatByData[indexPath.row].type == "file" {
               let cell:SenderImageCell = tbl_Chat.dequeueReusableCell(withIdentifier: "SenderImageCell", for: indexPath) as! SenderImageCell
               cell.selectionStyle = .none
                let file = (chatByData[indexPath.row].file ?? "")
                if chatByData[indexPath.row].file_type ?? "" == "image" {
                   cell.postImg.sd_setImage(with: URL(string: (file)), placeholderImage: UIImage(named: ""))
                }else{
                   let img = convertBase64StringToImage(imageBase64String: file)
                    cell.postImg.image = img
                 }
                 cell.imageBtn.tag = indexPath.row
                 cell.imageBtn.addTarget(self, action: #selector(self.redirectDetailScreen(sender:)), for: .touchUpInside)
                
                 return cell
              }else{
                let cell:SenderChatCell = tbl_Chat.dequeueReusableCell(withIdentifier: "SenderChatCell", for: indexPath) as! SenderChatCell
                cell.selectionStyle = .none
                cell.lbl_msg.text = chatByData[indexPath.row].message ?? ""
                let jjj = chatByData[indexPath.row].created_at ?? ""
                let date = ChatViewController.formatDat(date: jjj)
                cell.lbl_Date.text = date
          
                return cell
              }
            }else{
                 if chatByData[indexPath.row].type == "file" {
                     let cell:ReciverImageCell = tbl_Chat.dequeueReusableCell(withIdentifier: "ReciverImageCell", for: indexPath) as! ReciverImageCell
                     cell.selectionStyle = .none
                      let file = (chatByData[indexPath.row].file ?? "")
                      print("file",file)
                      print("file_type",chatByData[indexPath.row].file_type ?? "")
                      if chatByData[indexPath.row].file_type ?? "" == "image" {
                         cell.postImg.sd_setImage(with: URL(string: (file)), placeholderImage: UIImage(named: ""))
                      }else{
                         let img = convertBase64StringToImage(imageBase64String: file)
                          cell.postImg.image = img
                     }
                     cell.imageBtn.tag = indexPath.row
                     cell.imageBtn.addTarget(self, action: #selector(self.redirectDetailScreen(sender:)), for: .touchUpInside)
                   
                     return cell
                    }else{
                    let cell:ReciverChatCell = tbl_Chat.dequeueReusableCell(withIdentifier: "ReciverChatCell", for: indexPath) as! ReciverChatCell
                    cell.selectionStyle = .none
                    cell.lbl_msg.text = chatByData[indexPath.row].message ?? ""
                    let jjj = chatByData[indexPath.row].created_at ?? ""
                    let date = ChatViewController.formatDat(date: jjj)
                    cell.lbl_Date.text = date
                 
                    return cell
                }
          }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    @objc func redirectDetailScreen(sender:UIButton){
        let data = chatByData[sender.tag]
        if chatByData[sender.tag].file_type ?? "" == "image" {
        DispatchQueue.main.async {
            let imageview = UIImageView()
            imageview.sd_setImage(with: URL(string: data.file ?? ""), placeholderImage: UIImage(named: "PostPlaceholder.png"),options: SDWebImageOptions(rawValue: 3), completed: { (image, error, cacheType, imageURL) in
                if (image != nil){
                    let imageInfo   = GSImageInfo(image: image!, imageMode: .aspectFit)
                    let transitionInfo = GSTransitionInfo(fromView: sender)
                    let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
                    imageViewer.dismissCompletion = {
                        print("dismissCompletion")
                    }
                    self.navigationController!.present(imageViewer, animated: true, completion: nil)
                   }
               })
            }
        }else{
            DispatchQueue.main.async {
                let file = (self.chatByData[sender.tag].file ?? "")
                let img = self.convertBase64StringToImage(imageBase64String: file)
                let imageInfo   = GSImageInfo(image: img, imageMode: .aspectFit)
                 let transitionInfo = GSTransitionInfo(fromView: sender)
                 let imageViewer = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
                 imageViewer.dismissCompletion = {
                     print("dismissCompletion")
                 }
                self.navigationController!.present(imageViewer, animated: true, completion: nil)
              }
        }
    }
    fileprivate func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        let image = UIImage(data: imageData!)
        return image!
    }
    @IBAction func btn_Plus_Action(_ sender: Any) {
        showActionSheet()
    }
    func showActionSheet(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
        actionSheetController.view.tintColor = UIColor.black
        let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
        { action -> Void in
            self.camera()
        }
        actionSheetController.addAction(saveActionButton)
        let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
        { action -> Void in
            self.gallery()
        }
        actionSheetController.addAction(deleteActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    func camera() {
        let myPickerControllerCamera = UIImagePickerController()
        myPickerControllerCamera.delegate = self
        myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
        myPickerControllerCamera.allowsEditing = true
        self.present(myPickerControllerCamera, animated: true, completion: nil)
    }
    func gallery() {
        let myPickerControllerGallery = UIImagePickerController()
        myPickerControllerGallery.delegate = self
        myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerControllerGallery.allowsEditing = true
        self.present(myPickerControllerGallery, animated: true, completion: nil)
    }
    //MARK:- UIImagePickerController delegate Methods
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        let jpegCompressionQuality: CGFloat = 0.5
        if let base64String = selectedImage.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString() {
            let perms:[String:Any]  = [
                "gift_id": gift_id,
                "sender_id": sender_id,
                "sent_by": sender_id,
                "is_seen": "0",
                "receiver_id": receiver_id,
                "chatId": self.chatId,
                "type":"file",
                "file":base64String,
                "message":self.txtMessage.text!
            ]
            var jsonData: Data? = nil
            do {
                jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted /* Pass 0 if you don't care about the readability of the generated string */)
            } catch {
                print(error.localizedDescription)
            }
               var jsonString: String? = nil
                if let jsonData = jsonData {
                jsonString = String(data: jsonData, encoding: .utf8)
               self.socket?.emit("sendMessage", perms)
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: perms, options: .prettyPrinted)
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                   
                    if let dictFromJSON = decoded as? [String:Any] {
                        chatByData.append(chatListData(created_at: "", id: 0, gift_id: 0, message: "", sent_by: Int(sender_id), is_seen: "", type: "file", file_type: "local", last_message: last_message(chat_id: 0, createdAt: "", file: "", fileExtension: "", fivarype: "", id: 0, isSeen: "", message: "", sent_by: 0, sender_detail: sender_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), type: "", updatedAt: ""), sent_by_detail: sent_by_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), receiver_detail: receiver_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), receiverId: 0, sender_detail: sender_detail(id: 0, name: "", first_name: "", last_name: "", email: "", image: ""), sender_id: Int(sender_id), updatedAt: "", unseen_message_count: 0, file: base64String))
                        self.txtMessage.text = ""
                        Seen ()
                        self.txtMessage.resignFirstResponder()
                        self.tbl_Chat.reloadData()
                        if self.chatByData.count > 0 {
                        DispatchQueue.main.async {
                            let indexPath = IndexPath(row: self.chatByData.count-1, section: 0)
                            self.tbl_Chat.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                       }
                    }
                } catch {
                print(error.localizedDescription)
               }
            }
            dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func btn_Back_Action(_ sender: Any) {
        if AppDelegate.sharedInstance().chatType == 1 {
            AppDelegate.sharedInstance().chatType = 0
            self.socket?.disconnect()
            APPDELEGATE.configureTabbar()
          }else{
          self.socket?.disconnect()
          self.navigationController?.popViewController(animated: true)
         }
    }

}
extension ChatViewController {
  
    class func formatDat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let convertedDate = dateFormatter.date(from: date)
        guard let date = convertedDate else {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm a"
            let convertedDate: String = dateFormatter.string(from: currentDate)
            return convertedDate
        }
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = .current
        let timeStamp = dateFormatter.string(from: date)
        return timeStamp
       }
}
