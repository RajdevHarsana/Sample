//
//  DetailVC.swift
//  Gifts
//
//  Created by Apple on 01/06/22.
//

import UIKit
import Designable
import SDWebImage
import GSImageViewerController

class DetailVC: UIViewController {


    @IBOutlet weak var btnDetail: DesignableButton!
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var LblMiles: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var LblDescption: UILabel!
    @IBOutlet weak var LblProductName: UILabel!

    
    var currentpage : String?
    var totalProduct : String?
    var productTitle : String?
    var productDescp : String?
    var productMiles : String?
    var GiftId : Int?
    var Giver_Id : Int?
    var imagesDetail = [String]()
    var productimg = [Giftimages]()
    var StoreImages = [perivousDetail]()
    var imageUrl : URL?
    struct perivousDetail {
        var image : UIImage?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productimg)

        LblDescption.text? = productDescp ?? ""
        LblProductName.text? = productTitle ?? ""
        
        if productMiles ?? "" == "0 Miles away from me" {
            LblMiles.text? = "1 Miles away from me"
        }else{
            LblMiles.text? = productMiles ?? ""
        }
        if UserStoreSingleton.shared.userType == "giver"{
         btnDetail.setTitle("Edit Details", for: .normal)
        }else{
            btnDetail.setTitle("May I?", for: .normal)
            btnDelete.isHidden = true
        }
        pageControl.hidesForSinglePage = true
        self.navigationController?.navigationBar.isHidden = true
        productCollection.delegate = self
        productCollection.dataSource = self
        productCollection.reloadData()
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        if UserStoreSingleton.shared.userType == "giver"{
            btnDetail.setTitle("Edit Details", for: .normal)
        }else{
            btnDetail.setTitle("May I?", for: .normal)
        }
    }
    
    @IBAction func actionback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionDeletePost(_ sender: Any) {
        self.popupAlert(title: "From Me 2 U", message: "Are you sure, delete this Gift", actionTitles: ["Ok","Cancel"], actions:[{action1 in
            self.deleteGift()
           
        },{action2 in
            self.dismiss(animated: true, completion: nil)
        }, nil])
    }
    
    
    @IBAction func actionDetail(_ sender: Any) {
        
        if UserStoreSingleton.shared.userType == "giver"{
            let objRef : AddNewGiftVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewGiftVC") as! AddNewGiftVC
            objRef.productDetailImage = productimg
            objRef.arrDetailImages = productimg
            let id = productimg[(sender as AnyObject).tag].id ?? 0
            objRef.Gift_Id = String(id)
            objRef.ScreenCheck = "Detail"
            objRef.productTile =  LblProductName.text ?? ""
            objRef.productDescp = LblDescption.text ?? ""
           self.navigationController?.pushViewController(objRef, animated: true)
        }else{
           requestForGift()
        }
    }
}

//MARK:- UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension DetailVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return productimg.count
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollCell", for: indexPath) as? DetailCollCell
          
          if productimg.count == 0 {
              cell?.imageCountView.isHidden = true
          }else{
              cell?.imageCountView.isHidden = false
              cell?.LblTotalImages.text = String(productimg.count)
          }
          let gift_id = productimg[indexPath.row].gift_id
          GiftId = gift_id
          let giver_id = productimg[indexPath.row].user_id
          Giver_Id = giver_id
          let carImg = productimg[indexPath.row].image
          cell?.productImg.sd_setImage(with: URL(string: carImg!), placeholderImage: UIImage(named: ""))
          let imageUrl = carImg
          print(imageUrl!)
          imagesDetail.append(carImg ?? "")
          cell?.btnZoomImage.tag = indexPath.row
          cell?.btnZoomImage.addTarget(self, action: #selector(ZoomImage(sender:)), for: .touchUpInside)
       
          return cell!
      }
  
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = view.frame.size.width - 22
            return CGSize(width: width - 16, height: 230)
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.frame.width
        let margin = width * 0.3
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return collectionView.frame.width * 0.3 / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let indexVal = indexPath.row
//        print(indexVal)
//        if let cell = collectionView.cellForItem(at: indexPath) as? DetailCollCell {
//            cell.selectedIndexPath(indexPath)
//            let inddd = indexPath.row
//            print("inddd",inddd)
//            let zoomCtrl = VKImageZoom()
//            let carImg = productimg[indexPath.row].image
//            zoomCtrl.image_url = URL.init(string: carImg ?? "")
//            self.present(zoomCtrl, animated: true, completion: nil)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      
        if let cell = cell as? DetailCollCell {
            if indexPath.row == 0 {
                cell.LblScrollImg.text = "\("1") \("/")"
            }else{
                let increment = (indexPath.row) + 1
                cell.LblScrollImg.text = "\(increment)\("/")"
          
            }
        }

    }
    @objc func ZoomImage(sender: UIButton){
        let data = productimg[sender.tag]
        DispatchQueue.main.async {
            let imageview = UIImageView()
            imageview.sd_setImage(with: URL(string: data.image ?? ""), placeholderImage: UIImage(named: "PostPlaceholder.png"),options: SDWebImageOptions(rawValue: 3), completed: { (image, error, cacheType, imageURL) in
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
    }
//    @objc func ZoomImage(sender: UIButton){
//        let zoomCtrl = VKImageZoom()
//        let carImg = productimg[sender.tag].image
//        zoomCtrl.image_url = URL.init(string: carImg ?? "")
//        self.present(zoomCtrl, animated: true, completion: nil)
//       // return cell
//    }

}
