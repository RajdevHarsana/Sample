//
//  AddNewGiftVC.swift
//  Gifts
//
//  Created by Apple on 02/06/22.
//

import UIKit
import SDWebImage
import BSImagePicker
import Photos
import AssetsLibrary
import Alamofire
import GoogleMobileAds

class AddNewGiftVC: BaseViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtfldGift: UITextField!
    @IBOutlet weak var imgCollection: UICollectionView!
    @IBOutlet weak var viewImgCollection: UIView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    @IBOutlet weak var giftDescpt: UITextView!
    @IBOutlet weak var LblTitle: UILabel!
    @IBOutlet weak var btnCamera: UIButton!
    
    var imgName = ""
   
    var detailImages = [UIImage]()
    var productDetailImage = [Giftimages]()
    var arrDetailImages = [Any]()
    var arrImages = [Any]()
    var images = [UIImage]()
    var arrImage_id = [Int]()
    var productTile : String?
    var productDescp : String?
    
    var interstitial: GADInterstitialAd?

    private var selectedImages: [PHAsset] = []
    var ScreenCheck = ""
    var updateImg = false
    //Mark:- storing multiple images
    var SelectedAssets = [PHAsset]()
    var Gift_Id : String?
    var PhotoArray = [UIImage]()
    var imageFrom = false
    let placeholder = "Placeholder"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.ScreenCheck == "Detail" {
            LblTitle.text = "Edit details"
            txtfldGift.text = productTile ?? ""
            giftDescpt.text = productDescp ?? ""
            lblPlaceholder.text = ""
            print(productDetailImage)
            for i in 0..<productDetailImage.count {
                let Urls = productDetailImage[i].image
                if productDetailImage[i].image == "image" {
                    DispatchQueue.global(qos: .background).async {
                      do{
                          DispatchQueue.main.async { [self] in
                              downloadVideoLinkAndCreateAsset(Urls!)
                           }
                        }
                     }
                  }else{
                      DispatchQueue.global(qos: .background).async {
                        do{
                            let data = try Data.init(contentsOf: URL.init(string:Urls!)!)
                            DispatchQueue.main.async { [self] in
                                let image = UIImage(data: data)
                                print("image",image as Any)
                                arrImages.append(image as Any)
                                if productDetailImage.count == arrImages.count {
                                    print("arrImages",arrImages)
                                    imgCollection.reloadData()
                                  }
                               }
                            }catch{
                        }
                     }
                  }
               }
            }else{
            lblPlaceholder.text = "Description"
            LblTitle.text = "Add a new gift"
            if UserStoreSingleton.shared.isLoggedIn == true {
                let monthly = defaultValues.value(forKey: "monthly") as? String ?? ""
                let yearly = defaultValues.value(forKey: "yearly") as? String ?? ""
                if monthly == "monthly" || yearly == "yearly" {
                }else{
                   self.openAds()
                }
            }
        }
        giftDescpt.delegate = self
        imgCollection.dataSource = self
        imgCollection.delegate = self
       
        imgCollection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    private func openAds() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:APIs.OpenAdds,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
            interstitial?.present(fromRootViewController: self)
        })
    }
    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
            guard let videoURL = URL(string: videoLink) else { return }
            guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
                URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                    guard let location = location else { return }
                    let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                    do {
                        try FileManager.default.moveItem(at: location, to: destinationURL)
                        PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                            if authorizationStatus == .authorized {
                                PHPhotoLibrary.shared().performChanges({
                                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)}) { completed, error in
                                        if completed {
                                            print("Video asset created")
                                            self.arrImages.append(destinationURL as Any)
                                            if self.productDetailImage.count == self.arrImages.count {
                                                DispatchQueue.main.async {
                                                    print("arrImages",self.arrImages)
                                                    self.imgCollection.reloadData()
                                                }
                                            }
                                        } else {
                                            print(error as Any)
                                        }
                                   }
                              }
                        })
                    } catch { print(error) }
                    
                }.resume()

            } else {
                let destination = documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent)
                print("File already exists at destination url")
                self.arrImages.append(destination as Any)
                if self.productDetailImage.count == self.arrImages.count {
                   
                    print("arrImages",self.arrImages)
                    DispatchQueue.main.async {
                    self.imgCollection.reloadData()
                    }
                }
          }
    }
    func textViewDidChange(_ textView: UITextView) {
        lblPlaceholder.isHidden = !textView.text.isEmpty
    }
    @IBAction func actionAddImg(_ sender: Any) {
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
            self.openImageGallery()
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
    
    func openImageGallery() {
        let vc = BSImagePickerViewController()
         vc.maxNumberOfSelections = 6
         //display picture gallery
         self.bs_presentImagePickerController(vc, animated: true,
                                              select: { (asset: PHAsset) -> Void in
         }, deselect: { (asset: PHAsset) -> Void in
             // User deselected an assets.
         }, cancel: { (assets: [PHAsset]) -> Void in
             // User cancelled. And this where the assets currently selected.
         }, finish: { (assets: [PHAsset]) -> Void in
             // User finished with these assets
             for i in 0..<assets.count
             {
                 if self.ScreenCheck == "Detail" {
                     self.updateImg = true
                     self.SelectedAssets.append(assets[i])
                 }else{
                     self.SelectedAssets.append(assets[i])
                 }
             }
            self.convertAssetToImages()

         }, completion: nil)

     }
    //MARK:- UIImagePickerController delegate Methods
        @objc func imagePickerController(_ picker: UIImagePickerController,
                                         didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if mediaType  == "public.image" {
            guard let selectedImage = info[.originalImage] as? UIImage else {
                fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            }
//                let image = selectedImage
//                let targetSize = CGSize(width: 800, height: 800)
//                let scaledImage = image.scalePreservingAspectRatio(
//                    targetSize: targetSize
//                )
                DispatchQueue.main.async {
                self.arrImages.append(selectedImage.resize(800, 800) ?? "")
                print("arrImages",self.arrImages)
                self.imgCollection.reloadData()
               }
            }
            if mediaType == "public.movie" {
                if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                    arrImages.append(videoURL)
                    print("arrImages",arrImages)
                    self.imgCollection.reloadData()
                   }
                }
            }
            dismiss(animated: true, completion: nil)
        }
        func fromHeicToJpg(heicPath: String, jpgPath: String) -> UIImage? {
            let heicImage = UIImage(named:heicPath)
            let jpgImageData = heicImage!.jpegData(compressionQuality: 1.0)
            FileManager.default.createFile(atPath: jpgPath, contents: jpgImageData, attributes: nil)
            let jpgImage = UIImage(named: jpgPath)
            return jpgImage
        }
        func convertAssetToImages() -> Void {
        if SelectedAssets.count != 0{
            for i in 0..<SelectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 800.0, height: 800.0), contentMode: .aspectFit, options: option, resultHandler: {(result,info) -> Void in
                    thumbnail = result!
                })
                if updateImg == true {
                    let data = thumbnail.jpegData(compressionQuality: 0.6)
                    let newImage = UIImage(data: data!)
                    print("newImage",newImage ?? "")
                    images.append(newImage!)
                    self.arrImages.append(newImage ?? "")
                    print("self.arrImages",self.arrImages)
                    if self.arrImages.count != 0{
                        imgCollection.isHidden = false
                    }else{
                        imgCollection.isHidden = true
                    }
                    self.imgCollection.reloadData()
                }else{
                    let data = thumbnail.jpegData(compressionQuality: 0.6)
                    let newImage = UIImage(data: data!)
                    print("newImage",newImage ?? "")
                    images.append(newImage!)
                    self.arrImages.append(newImage ?? "")
                    print("self.arrImages",self.arrImages)
                    if self.arrImages.count != 0{
                        imgCollection.isHidden = false
                    }else{
                        imgCollection.isHidden = true
                    }
                    self.imgCollection.reloadData()
                }
            }
        }
        self.SelectedAssets.removeAll()
    }
    
    func postJobs(){
     
        if Helper.shared.isFieldEmpty(field: txtfldGift.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.selectStore)
            return
        }
        if Helper.shared.isFieldEmpty(field: giftDescpt.text ?? "") {
            DisplayBanner.show(message: ErrorMessages.discription)
            return
        }
        if arrImages.count == 0 {
            DisplayBanner.show(message: ErrorMessages.addImages)
            return
        }
        
        var header = HTTPHeaders()
        if let token =    UserStoreSingleton.shared.userToken {
            print("Access Token --",token)
            header = [
                "authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        }
        else {
            DisplayBanner.show(message: "Token not accessible")
        }
        objHudShow()
        
        let latitude = defaultValues.value(forKey: "latitude") ?? ""
        let longitude = defaultValues.value(forKey: "longitude") ?? ""
        let parameters: [String:Any]  = ["title":txtfldGift.text ?? "",
                                          "description":giftDescpt.text ?? "",
                                         "latitude":latitude,
                                         "longitude":longitude]
         
           print(parameters)
           AF.upload(multipartFormData: { multiPart in
               for i in 0..<self.arrImages.count{
                   let randemId = self.generateTransactionId(length: 10)
                   
                   self.imgName = randemId + ".png"
                   let imageData1 = (self.arrImages[i] as? UIImage)?.jpegData(compressionQuality: 0.8)!
                   let iiim = (self.arrImages[i] as? UIImage)?.pngData()
                   print(imageData1?.first ?? "")
                   print(imageData1?.last ?? "")
                   multiPart.append(imageData1!, withName: "file[]" , fileName: self.imgName, mimeType: "jpg/png/jpeg")
                  }

               for (key, value) in parameters {
                if value is String {
                   if let temp = value as? String {
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                   }
               }
               else if value is NSArray {
                   if let temp = value as? [Double]{
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                   }
                   else if let temp = value as? [Int]{
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                   }
                   else if let temp = value as? [String]{
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                     }
                  }
              }
           }, to: BaseViewController.ADD_New_Gift, usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON(completionHandler: { response in
               
               switch response.result {
               case .success:
                   print(response)
                   Loader.stop()
                   self.objHudHide()
                   
                   self.navigationController?.popViewController(animated: true)

                   break
               case .failure( let error):
                   print(error.localizedDescription)
                   Loader.stop()
                   self.objHudHide()
               }
           })
    }
    
    func updatePostJobs(){
        objHudShow()
        var header = HTTPHeaders()
        if let token =    UserStoreSingleton.shared.userToken {
            print("Access Token --",token)
            header = [
                "authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
        }
        else {
            DisplayBanner.show(message: "Token not accessible")
        }
        let stringArray1 = arrImage_id.map(String.init)
        
        print(stringArray1)
        let removeBracket1 = stringArray1.joined(separator: " ")
        print(removeBracket1)
        let addSTring1 = stringArray1.joined(separator: ",")
        print(addSTring1)
    
        let parameters: [String:Any]  = ["title":txtfldGift.text ?? "",
                                       "description":giftDescpt.text ?? "",
                                         "gift_id": Gift_Id ?? "",
                                         "image_id": stringArray1,
                                         "type_ios": "IOS"
        ]
            
           print(parameters)
           AF.upload(multipartFormData: { multiPart in
               print(self.arrImages.count)
               for i in 0..<self.arrImages.count{
                   let randemId = self.generateTransactionId(length: 10)
                   
                   self.imgName = randemId + ".png"
                   let imageData1 = (self.arrImages[i] as? UIImage)?.jpegData(compressionQuality: 0.8)!
                   let iiim = (self.arrImages[i] as? UIImage)?.pngData()
                   print(imageData1?.first ?? "")
                   print(imageData1?.last ?? "")
                   multiPart.append(imageData1!, withName: "file[]" , fileName: self.imgName, mimeType: "jpg/png/jpeg")
                  }


               for (key, value) in parameters {
                if value is String {
                   if let temp = value as? String {
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                   }
               }
               else if value is NSArray {
                   if let temp = value as? [Double]{
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                   }
                   else if let temp = value as? [Int]{
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                   }
                   else if let temp = value as? [String]{
                       multiPart.append(temp.description.data(using: .utf8)!, withName: key)
                     }
                  }
              }
           }, to: BaseViewController.Update_New_Gift, usingThreshold: UInt64.init(), method: .post, headers: header).responseJSON(completionHandler: { response in
               
               switch response.result {
               case .success:
                   print(response)
                   Loader.stop()
                   self.objHudHide()
                   let responsedata = response.data
                   do {
                       let responseModel = try JSONDecoder().decode(UpdateImageModel.self, from: responsedata!)
                       print(responseModel)
                    
                       let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                       
                       self.navigationController?.pushViewController(vc!, animated: true)
                        } catch {
                              print(error)
                             // completed(.failure(.invalidData))
                        }
                  

                   break
               case .failure( let error):
                   print(error.localizedDescription)
                   Loader.stop()
                   
                   
               }
           })
    }
    
    func generateTransactionId(length: Int) -> String {
            var result = ""
            let base62chars = [Character]("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
            let maxBase : UInt32 = 62
            let minBase : UInt16 = 32
            for _ in 0..<length {
                let random = Int(arc4random_uniform(UInt32(min(minBase, UInt16(maxBase)))))
                result.append(base62chars[random])
            }
            return result
    }
   
    @IBAction func actionEditDetails(_ sender: Any) {
        if ScreenCheck == "Detail" {
            updatePostJobs()
        }else{
            postJobs()
        }
       }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func textViewDidBeginEditing(_ textView: UITextView) {
        if giftDescpt.textColor == UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1.0) {
            lblPlaceholder.isHidden = true
            giftDescpt.text = ""
            giftDescpt.textColor = UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1.0)
        }
    }
    
    @objc func textViewDidEndEditing(_ textView: UITextView) {
        if giftDescpt.text == "" {
            lblPlaceholder.isHidden = false
           // txtviewAbout.text = "About..."
            giftDescpt.textColor = UIColor(red: 115/255, green: 47/255, blue: 41/255, alpha: 1.0)
        }
    }
   }

//MARK:- UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension AddNewGiftVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if ScreenCheck == "Detail"{
               return arrImages.count
           }else{
            return arrImages.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddGiftCollCell", for: indexPath) as? AddGiftCollCell
        if ScreenCheck == "Detail"{
            if UserStoreSingleton.shared.userType == "giver"{
                cell?.giftImg.image = arrImages[indexPath.row] as? UIImage
                if updateImg == true {
                    cell?.giftImg.image = arrImages[indexPath.row] as? UIImage
                }else{
                    let arr = productDetailImage[indexPath.row].gift_id ?? 0
                    print(productDetailImage)
                    Gift_Id = String(arr)
                    let image_id = productDetailImage[indexPath.row].id ?? 0
                    arrImage_id.append(image_id)
                    print(arrImage_id)
                }
                cell?.btnDelete.tag = indexPath.row
                cell?.btnDelete.addTarget(self, action: #selector(DeleteImage(sender:)), for: .touchUpInside)
            }else{
                print("RECEIVER SIDE")
            }
        }else{
            cell?.giftImg.image = arrImages[indexPath.row] as? UIImage
            cell?.btnDelete.tag = indexPath.row
            cell?.btnDelete.addTarget(self, action: #selector(DeleteImage(sender:)), for: .touchUpInside)
        }
    
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if ScreenCheck == "Detail"{
          let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
          let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
          let size:CGFloat = (imgCollection.frame.size.width - space) / 2.0
          return CGSize(width: size, height: 80)
        }else{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size:CGFloat = (imgCollection.frame.size.width - space) / 2.0
            return CGSize(width: size, height: 80)
        }
      }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    @objc func DeleteImage(sender: UIButton){
 
            self.arrImages.remove(at: sender.tag)
                self.imgCollection.reloadData()
    }
    

}
    
  

