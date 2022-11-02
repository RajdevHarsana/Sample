//
//  NotificationVC.swift
//  Gifts
//
//  Created by Apple on 02/06/22.
//

import UIKit
import SDWebImage

class NotificationVC: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    let df = DateFormatter()
    var notificationId: Int?
    var booking_Id : Int?
    var statusId : String?
    
    var arrNotification = [NotificationData]() {
        didSet {
            tblView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.tblView.tableFooterView = UIView()
        tblView.delegate = self
        tblView.dataSource = self
        tblView.rowHeight = 140
        UIApplication.shared.applicationIconBadgeNumber = 0
         getNotificationList()
    }
    override func viewWillAppear(_ animated: Bool) {
      self.tabBarController?.tabBar.isHidden = false
      getNotificationList()
    }
    
    @IBAction func actionback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func bookingStatusUpdate(booking_id: Int?,status: String?,notification_id: Int?){
        let param:[String:Any] = [
               "booking_id":booking_id ?? 0,
               "status": statusId ?? "",
               "notification_id": notificationId ?? ""
               ]
        OnboardViewModel.shared.bookingStatus(param: param, isAuthorization: true) { [self] (data) in
            DisplayBanner.show(message: data.message ?? "")
            getNotificationList()
        }
    }
}
//MARK:- UITableViewDelegate,UITableViewDataSource
extension NotificationVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell") as? NotificationTableViewCell
        if UserStoreSingleton.shared.userType == "giver" {
            cell?.lblMessage.text = arrNotification[indexPath.row].message ?? ""
            let jjj = arrNotification[indexPath.row].created_at ?? ""
            let date = NotificationVC.formatDat(date: jjj)
            print(date)
            cell?.Lbldate.text = date
            let carImg = arrNotification[indexPath.row].data ?? ""
            cell?.userImg.sd_setImage(with: URL(string: carImg), placeholderImage: UIImage(named: "userimg.png"))
            cell?.btnMessage.tag = indexPath.row
            cell?.btnMessage.addTarget(self, action: #selector(bookinStatus(sender:)), for: .touchUpInside)
            cell?.btnCross.tag = indexPath.row
            cell?.btnCross.addTarget(self, action: #selector(bookingDeclineStatus(sender:)), for: .touchUpInside)
            
            if arrNotification[indexPath.row].type == "BOOKING_REQUEST" {
                cell?.lblStatus.text = "From me to you"
                cell?.crossWidth.constant = 40
                cell?.btnMessage.isUserInteractionEnabled = true
            }
            else if arrNotification[indexPath.row].type == "BOOKING_ACCEPTED" {
                cell?.lblStatus.text = "Message"
                cell?.crossWidth.constant = 0
                cell?.btnMessage.isUserInteractionEnabled = true
            }
            
            else if arrNotification[indexPath.row].type == "BOOKING_REJECTED" {
                cell?.lblStatus.text = "Rejected"
                cell?.crossWidth.constant = 0
                cell?.btnMessage.isUserInteractionEnabled = false
            }
           }else{
            cell?.lblMessage.text = arrNotification[indexPath.row].receiver_msg ?? ""
            let jjj = arrNotification[indexPath.row].created_at ?? ""
            let date = NotificationVC.formatDat(date: jjj)
            print(date)
            cell?.Lbldate.text = date
            cell?.userImg.sd_imageIndicator = SDWebImageActivityIndicator.white
            let carImg = arrNotification[indexPath.row].data ?? ""
            cell?.userImg.sd_setImage(with: URL(string: carImg), placeholderImage: UIImage(named: "userimg.png"))
            let  booking_id = arrNotification[indexPath.row].booking_id
            booking_Id = booking_id
            let notificationid = arrNotification[indexPath.row].id
            notificationId = notificationid
            let status = arrNotification[indexPath.row].status
            statusId = status
            
            if arrNotification[indexPath.row].type == "BOOKING_ACCEPTED" {
                cell?.lblStatus.text = "Message"
                cell?.crossWidth.constant = 0
                cell?.btnMessage.isUserInteractionEnabled = true

            }else if arrNotification[indexPath.row].type == "BOOKING_REJECTED" {
                cell?.lblStatus.text = "Rejected"
                cell?.crossWidth.constant = 0
                cell?.btnMessage.isUserInteractionEnabled = false

            }else{
              cell?.lblStatus.text = "Pending"
                cell?.btnMessage.isUserInteractionEnabled = false
                cell?.btnCross.isHidden = true
                cell?.crossWidth.constant = 0
            }
         
            cell?.btnMessage.tag = indexPath.row
            cell?.btnMessage.addTarget(self, action: #selector(bookinStatus(sender:)), for: .touchUpInside)
            cell?.btnCross.tag = indexPath.row
            cell?.btnCross.addTarget(self, action: #selector(bookingDeclineStatus(sender:)), for: .touchUpInside)
        }
      
        return cell!
    }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
    }
    @objc func bookinStatus(sender: UIButton){
        print("work-----------")
        if arrNotification[sender.tag].type == "BOOKING_ACCEPTED" {
        let objRef : ChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        AppDelegate.sharedInstance().chatType = 0
        if arrNotification[sender.tag].user_id == UserStoreSingleton.shared.userID {
            objRef.receiver_id = "\(arrNotification[sender.tag].giver_id ?? "")"
            objRef.sender_id = "\(arrNotification[sender.tag].user_id ?? 0)"
            objRef.gift_id = "\(arrNotification[sender.tag].gift_id ?? 0)"
            objRef.chat_id = objRef.sender_id + objRef.receiver_id
        }else{
            objRef.sender_id = "\(arrNotification[sender.tag].giver_id ?? "")"
            objRef.receiver_id = "\(arrNotification[sender.tag].user_id ?? 0)"
            objRef.gift_id = "\(arrNotification[sender.tag].gift_id ?? 0)"
            objRef.chat_id = objRef.receiver_id + objRef.sender_id
        }
        self.navigationController?.pushViewController(objRef, animated: true)
        }else{
         statusId = "2"
        let  booking_id = arrNotification[sender.tag].booking_id
        booking_Id = booking_id
        let notificationid = arrNotification[sender.tag].id
        notificationId = notificationid
        self.bookingStatusUpdate(booking_id: self.booking_Id, status: statusId, notification_id: notificationId)
        }
    }
    
    @objc func bookingDeclineStatus(sender: UIButton){
        statusId = "3"
        let  booking_id = arrNotification[sender.tag].booking_id
        booking_Id = booking_id
        let notificationid = arrNotification[sender.tag].id
        notificationId = notificationid
        self.popupAlert(title: "From Me to You", message: "Are you sure, you want to reject this booking?", actionTitles: ["Yes","No"], actions:[{action1 in
            self.bookingStatusUpdate(booking_id: self.booking_Id, status: "3", notification_id: self.notificationId)
        },{action2 in
            self.dismiss(animated: true, completion: nil)
        }, nil])
    }
}
extension NotificationVC {
  
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
