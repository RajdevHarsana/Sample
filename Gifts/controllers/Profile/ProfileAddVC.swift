//
//  ProfileVC.swift
//  Gifts
//
//  Created by Apple on 02/06/22.
//

import UIKit
import SDWebImage
import Designable
import Charts // You need this line to be able to use Charts Library

class ProfileAddVC: BaseViewController {
    var imgArr = [UIImage.init(named: "img1"),UIImage.init(named: "img2"),UIImage.init(named: "img3")]

    @IBOutlet weak var imgCollView: UICollectionView!
    @IBOutlet weak var imgAdd: UIImageView!
    @IBOutlet weak var LblMonthGifts: UILabel!
    @IBOutlet weak var receiverImg: DesignableImageView!
    @IBOutlet weak var userDetailViewHeight: NSLayoutConstraint!
    @IBOutlet weak var LbluserAddress: UILabel!
    @IBOutlet weak var LbluserName: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var receiverView: UIView!
    @IBOutlet weak var stateSwitch: UISwitch!
    @IBOutlet weak var giverView: UIView!
    @IBOutlet weak var LblDescription: UILabel!
    @IBOutlet weak var LbltotalGift: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var LblReceiverDesp: UILabel!
    @IBOutlet weak var LblReceiverAddress: UILabel!
    @IBOutlet weak var LblReceiverName: UILabel!
    @IBOutlet weak var chtChart: LineChartView!
    
    var dataEntries: [ChartDataEntry] = []

    var months = ["Jan" , "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
    var units = [0.0]
    var month = [""]
    var userStatus : String?
    
    var ProfileData = [Giftdetails]() {
        didSet {
            imgCollView.reloadData()
        }
    }
    
    var arrProductDetails = [Giftimages]()

    var arrGraph = [GraphData]() {
        didSet {
           
        }
    }

   let databozi =  [10.0, 11.0, 12.0,10.0, 11.0, 12.0,10.0, 11.0, 12.0,10.0, 11.0, 12.0]
    
    let onColor  = UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1)
    let offColor = UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.ProfileAction(notification:)), name: Notification.Name("Profile"), object: nil)
        units.removeAll()
        month.removeAll()
        stateSwitch.isOn =  false
        receiverView.isHidden = true
        imgCollView.dataSource = self
        imgCollView.delegate = self
        imgCollView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    @objc func ProfileAction(notification: Notification){
        self.navigationController?.popToRootViewController(animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        getProfile()
    }
    @IBAction func userSelect(_ sender: Any) {
       
    }
    @IBAction func actionEditProfile(_ sender: Any) {
        let objRef : EditProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(objRef, animated: true)
    }
    
    @IBAction func actionReceiverEdit(_ sender: Any) {
        let objRef : EditProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(objRef, animated: true)
    }
    
    @IBAction func switchUser(_ sender: Any) {
        if stateSwitch.isOn {
            stateSwitch.onTintColor = onColor
            userStatus = "receiver"
            giverView.isHidden = true
            receiverView.isHidden = false
            driverUpdateStatus()
        } else {
            
            stateSwitch.tintColor = offColor
            giverView.isHidden = false
            userStatus = "giver"
            receiverView.isHidden = true
            driverUpdateStatus()
        }
    }
    
    @IBAction func actionViewAll(_ sender: Any) {
          APPDELEGATE.configureTabbar()
        }
    }
    extension ProfileAddVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if ProfileData.count > 1 {
                btnViewAll.isHidden = false
                return 2
              }else{
               btnViewAll.isHidden = true
               return ProfileData.count
            }
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddimgCollCell", for: indexPath) as? AddimgCollCell
                arrProductDetails = ProfileData[indexPath.row].giftimages ?? [Giftimages]()
                let carImg = arrProductDetails[0].image
               cell?.productImg.sd_imageIndicator = SDWebImageActivityIndicator.white
                cell?.productImg.contentMode = .scaleAspectFit
                cell?.productImg.sd_setImage(with: URL(string: carImg!), placeholderImage: UIImage(named: ""))
                return cell!
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = view.frame.size.width - 22
            return CGSize(width: 100, height: 100)
          }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            4
 
    }
  
}

class  AddimgCollCell : UICollectionViewCell {
    //outlets
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
