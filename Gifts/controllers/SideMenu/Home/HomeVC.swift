//
//  HomeVC.swift
//  Gifts
//
//  Created by POSSIBILITY on 01/08/21.
//
import UIKit
import SDWebImage
import Toast_Swift
import Kingfisher
import Designable

class HomeVC: BaseViewController,UITextViewDelegate{
    
    //  OUTLETS ******************
    @IBOutlet weak var homeCollectionBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var btnAddGift: DesignableButton!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var homeCollection: UICollectionView!

    var isActivePlain = false
    var arrGetGift = [GiverObj]() {
        didSet {
            DispatchQueue.main.async {
                Loader.stop()
                self.homeCollection.reloadData()
            }
        }
    }
    var arrGetReceiverGift = [ReciverObj]() {
        didSet {
            DispatchQueue.main.async {
                Loader.stop()
                self.homeCollection.reloadData()
            }
        }
    }
    var GiftId : Int?
    var index : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        btnAddGift.isHidden = true
        homeCollection.delegate = self
        homeCollection.dataSource = self
        subscriptionConfig()
    }
    func setUpUI(){
         if UserStoreSingleton.shared.userType == "giver" {
            btnAddGift.isHidden = false
             LblTitle.text = "My Gifts"
        }else{
            btnAddGift.isHidden = true
            LblTitle.text = "Gifts"
            homeCollectionBottomConstraints.constant = 20
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpUI()
        Loader.start()
        getAllGifts()
    }
    override func viewWillDisappear(_ animated: Bool) {
        if UserStoreSingleton.shared.userType == "giver" {
            arrGetGift.removeAll()
        }else{
            arrGetReceiverGift.removeAll()
        }
     }
    func subscriptionConfig(){
        let utcTime = defaultValues.value(forKey: "createdAt") as? String ?? ""
        let dateFormatterT = DateFormatter()
        dateFormatterT.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatterT.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let startDate = dateFormatterT.date(from: utcTime)
        var dayComponent = DateComponents()
        dayComponent.day = 90
        let theCalendar = Calendar.current
        let firstDates = theCalendar.date(byAdding: dayComponent, to: startDate ?? Date())
        let Selecteddate =  DatetoString(format: "YYYY-MM-dd HH:mm:ss", date: firstDates ?? Date())
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let today = dateFormatter.string(from: now)
        let FreeTodayDate = formatter.date(from: today)
        let FreeTrialDate = formatter.date(from: Selecteddate)
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedDescending {
            print("First Date is greater then second date")
            let monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
            let yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
            if monthly == "monthly" || yearly == "yearly" {
                self.isActivePlain = true
            }else{
                self.isActivePlain = false
                SubscriptionPopup()
            }
        }
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedSame {
            print("freeTrial Both dates are same")
            self.isActivePlain = true
        }
        if FreeTodayDate?.compare(FreeTrialDate ?? Date()) == .orderedAscending {
            print("First Date is smaller then second date")
            self.isActivePlain = true
        }
   }
    //  MARK:-CUSTOM METHODS ********************************
    func SubscriptionPopup(){
        let alertController = UIAlertController(title: NSLocalizedString(SubscriptionTitle, comment: ""), message: NSLocalizedString(subscriptionMgs, comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default) {
                  UIAlertAction in
                NSLog("Cancel Pressed")
        }
         let okAction = UIAlertAction(title: NSLocalizedString("Subscribe", comment: ""), style: UIAlertAction.Style.default) { [self]
                  UIAlertAction in
            let objRef : SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
             objRef.isActive = true
            self.navigationController?.pushViewController(objRef, animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    //  MARK:-BUTTON ACTIONS  ********************************
    @IBAction func action_SideMenu(_ sender: Any) {
        let objRef:SearchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(objRef, animated: true)
    }
    @IBAction func actionAddGift(_ sender: Any) {
        if self.isActivePlain == false {
            SubscriptionPopup()
        }else{
         let objRef : AddNewGiftVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewGiftVC") as! AddNewGiftVC
         self.navigationController?.pushViewController(objRef, animated: true)
         }
    }
}
extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
          let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
          let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
          let size:CGFloat = (homeCollection.frame.size.width - space) / 2.0
          return CGSize(width: 140, height: 200)
      }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          if UserStoreSingleton.shared.userType == "giver"{
              return  arrGetGift.count//imgArr.count
          }else{
              return  arrGetReceiverGift.count//imgArr.count
          }
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionCell", for: indexPath) as? HomeCollectionCell
          
          if UserStoreSingleton.shared.userType == "giver" {
              cell?.lblView.text = "Delete"
              print(Giftimages.self)
              if arrGetGift[indexPath.row].giftimages?.first?.image == "" {

              }else{
                  let carImg = arrGetGift[indexPath.row].giftimages?.first?.image
                  cell?.productimg.sd_setImage(with: URL(string: carImg ?? ""), placeholderImage: UIImage(named: ""))
              }
              cell?.LblMiles.isHidden = true
              cell?.Lbltitle.text = arrGetGift[indexPath.row].title
              cell?.btnView.isHidden = false
              cell?.btnView.addTarget(self, action: #selector(deleteBtnPrsd), for: .touchUpInside)
              cell?.btnView.tag = indexPath.row
              
          }else{
              cell?.lblView.text = "View"
              print(Giftimages.self)
              if arrGetReceiverGift[indexPath.row].giftimages?.first?.image == "" {

              }else{
                  if arrGetReceiverGift[indexPath.row].distance ?? "" == "0 Miles away from me" {
                      cell?.LblMiles.text = "1 Miles away from me"
                  }else{
                  cell?.LblMiles.text = arrGetReceiverGift[indexPath.row].distance ?? ""
                  }
                  let carImg = arrGetReceiverGift[indexPath.row].giftimages?.first?.image
                  cell?.productimg.sd_setImage(with: URL(string: carImg ?? ""), placeholderImage: UIImage(named: ""))
              }
              cell?.btnView.isHidden = true
              cell?.Lbltitle.text = arrGetReceiverGift[indexPath.row].title
          }
          return cell!
      }
       @objc func deleteBtnPrsd(sender: UIButton){
           print(sender.tag)
           index = sender.tag
           self.popupAlert(title: "From Me 2 U", message: "Are you sure, delete this Gift", actionTitles: ["Ok","Cancel"], actions:[{action1 in
               self.GiftId = self.arrGetGift[sender.tag].id ?? 0
               print("GiftId",self.GiftId ?? 0)
               self.deleteGift()
              
           },{action2 in
               self.dismiss(animated: true, completion: nil)
           }, nil])
       }
       func deleteGift(){
        
        if !Connectivity.isConnectedToInternet {
            DisplayBanner.show(message: ErrorMessages.checkInternetConnectivity)
            return
        }
        let param:[String:Any] = [
            "gift_id": GiftId ?? 0
        ]
        OnboardViewModel.shared.giftDelete(param: param, isAuthorization: true) { [self] (data) in
            self.arrGetGift.remove(at: index ?? 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if UserStoreSingleton.shared.userType == "giver" {
            let objRef:DetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            objRef.productimg = arrGetGift[indexPath.row].giftimages ?? []
            objRef.productTitle = arrGetGift[indexPath.row].title ?? ""
            objRef.productDescp = arrGetGift[indexPath.row].description ?? ""
            self.navigationController?.pushViewController(objRef, animated: true)
        }else{
            if self.isActivePlain == false {
                SubscriptionPopup()
            }else{
            let objRef:DetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            objRef.productimg = arrGetReceiverGift[indexPath.row].giftimages ?? []
            objRef.productTitle = arrGetReceiverGift[indexPath.row].title ?? ""
            objRef.productDescp = arrGetReceiverGift[indexPath.row].description ?? ""
            objRef.productMiles = arrGetReceiverGift[indexPath.row].distance ?? ""
            self.navigationController?.pushViewController(objRef, animated: true)
            }
        }
    }
}
