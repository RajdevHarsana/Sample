////
////  WebService.swift
////  Gifts
////
////  Created by iOS on 30/08/19.
////  Copyright © 2019 POSSIBILITY SOLUTIONS. All rights reserved.
////
//
//import Foundation
//import UIKit
//import Alamofire
//import SVProgressHUD
//import SystemConfiguration
//import NVActivityIndicatorView
//class WebService: NSObject {
//    
//    static let shared:WebService = {
//        let sharedInsatnce = WebService()
//        return sharedInsatnce
//    }()
//    //MARK:- Acticity Indicator
//    var objNVHud = ActivityData(size: NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE, message: nil, messageFont: nil, type: NVActivityIndicatorType.ballRotateChase, color:BaseViewController.appColor, padding: nil, displayTimeThreshold: NVActivityIndicatorView.DEFAULT_BLOCKER_DISPLAY_TIME_THRESHOLD, minimumDisplayTime: NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME);
//    
//    func objHudShow(){
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(objNVHud,nil)
//    }
//    func objHudHide(){
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
//    }
//   
//    //********************** Api Get parms Method ******************
//    //MARK: - GET
//******************** Api Get Method ******************
//    //MARK: - Api GET Method
//       func GetMethods(url:String,parameters:[String:Any] , completion: @escaping (_ data:[String:Any]? , _ error:Error?) -> Void){
//           print(url)
//           print(parameters)
//           if !CheckInternet.Connection(){
//               Helper.Alertmessage(title: "Alert", message: "Please Check Internet Connection", vc: nil)
//           }
//           objHudShow()
//           let manager = Alamofire.SessionManager.default
//           manager.session.configuration.timeoutIntervalForRequest = 120
//           manager.request(url, method:.get, parameters: parameters, encoding: URLEncoding.default, headers: headersintoApi()).responseJSON { (response:DataResponse<Any>) in
//               self.objHudHide()
//               if response.result.isSuccess{
//                   print("Response Data: \(response)")
//                   if let data = response.result.value as? [String:Any]{
//                       completion(data , nil)
//                   }else{
//                       print("")
//                       completion(nil,response.error)
//                   }
//               }else{
//                   print("")
//                   completion(nil,response.error)
//                   print("Error \(String(describing: response.result.error))")
//               }
//         }
//    }
//    //********************** Api Post Method ******************
//    //MARK: - Api POST Method
//       func PostMethods(url:String,parameters:[String:Any] , completion: @escaping (_ data:[String:Any]? , _ error:Error?) -> Void){
//           print(url)
//           print(parameters)
//           if !CheckInternet.Connection(){
//               Helper.Alertmessage(title: "Alert", message: "Please Check Internet Connection", vc: nil)
//           }
//           objHudShow()
//           let manager = Alamofire.SessionManager.default
//           manager.session.configuration.timeoutIntervalForRequest = 120
//           manager.request(url, method:.post, parameters: parameters, encoding: URLEncoding.default, headers: headersintoApi()).responseJSON { (response:DataResponse<Any>) in
//               self.objHudHide()
//               if response.result.isSuccess{
//                   print("Response Data: \(response)")
//                   if let data = response.result.value as? [String:Any]{
//                       completion(data , nil)
//                   }else{
//                       print("")
//                       completion(nil,response.error)
//                   }
//               }else{
//                   print("")
//                   completion(nil,response.error)
//                   print("Error \(String(describing: response.result.error))")
//               }
//         }
//    }
//    
//    //MARK: - Api POSTa Method
//       func PostMethod(url:String,parameters:[String:Any] , completion: @escaping (_ data:[String:Any]? , _ error:Error?) -> Void){
//           print(url)
//           print(parameters)
//           if !CheckInternet.Connection(){
//               Helper.Alertmessage(title: "Alert", message: "Please Check Internet Connection", vc: nil)
//           }
//           let manager = Alamofire.SessionManager.default
//           manager.session.configuration.timeoutIntervalForRequest = 120
//           manager.request(url, method:.post, parameters: parameters, encoding: URLEncoding.default, headers: headersintoApi()).responseJSON { (response:DataResponse<Any>) in
//               if response.result.isSuccess{
//                   print("Response Data: \(response)")
//                   if let data = response.result.value as? [String:Any]{
//                       completion(data , nil)
//                   }else{
//                       print("")
//                       completion(nil,response.error)
//                   }
//               }else{
//                   print("")
//                   completion(nil,response.error)
//                   print("Error \(String(describing: response.result.error))")
//               }
//         }
//    }
//    func headersintoApi() -> [String:String]{
//        let string = defaultValues.string(forKey: "accessToken") ?? ""
//        print(string)
//        let headers = ["Content-Type":"application/x-www-form-urlencoded",
//                       "Accept":"application/json",
//                       "Authorization":"Bearer " + string]
//        return headers
//    }
//    func showlogoutAlert(){
//        let alert = UIAlertController(title: "", message: "Your Session is expired", preferredStyle: UIAlertController.Style.alert);
//        let action = UIAlertAction.init(title: "ok", style: .default) { (sction) in
//        }
//        alert.addAction(action)
//        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
//            window.rootViewController?.present(alert, animated: true, completion: nil)
//        }
//    }
//}
//

/*
 //
 //  AddNewGiftVC.swift
 //  Gifts
 //
 //  Created by Apple on 02/06/22.
 //

 import UIKit
 import SDWebImage

 class AddNewGiftVC: UIViewController {

     
     @IBOutlet weak var txtfldGift: UITextField!
     @IBOutlet weak var imgCollection: UICollectionView!
     @IBOutlet weak var viewImgCollection: UIView!
   //  var collectionView: UICollectionView!
     
     var imagesPath: [UIImage?] = []
     var imageArray: [String] = []
     var images = [UIImage]()
     
     private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 1
            let numOfColumns: CGFloat = 2
       //     let itemSize: CGFloat = (UIScreen.main.bounds.width - (numOfColumns - spacing) - 2) / 3
            layout.itemSize = CGSize(width: 60, height: 60)
            layout.minimumInteritemSpacing = spacing
            layout.minimumLineSpacing = spacing
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
            return layout
        }()
        
        private lazy var collectionView: UICollectionView = {
            let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
            collectionView.backgroundColor = .white
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            return collectionView
        }()
        
     
     override func viewDidLoad() {
         super.viewDidLoad()
         configureCollectionView()
     }
     
     private func configureCollectionView() {
            view.addSubview(collectionView)
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: viewImgCollection.safeAreaLayoutGuide.topAnchor),
                collectionView.bottomAnchor.constraint(equalTo: viewImgCollection.safeAreaLayoutGuide.bottomAnchor),
                collectionView.leadingAnchor.constraint(equalTo: viewImgCollection.safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: viewImgCollection.safeAreaLayoutGuide.trailingAnchor)
            ])
            collectionView.register(AddGiftCollCell.self, forCellWithReuseIdentifier: "AddGiftCollCell")
        }

     @IBAction func actionAddImg(_ sender: Any) {
         ImagePickerManager().pickImage(self){ [self] image,path  in
             print(path)
             images.insert(image, at: 0)
             collectionView.reloadData()
         }
     }
     
 }

 extension AddNewGiftVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return images.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
         let cell : AddGiftCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddGiftCollCell", for: indexPath) as! AddGiftCollCell
         let url = images[indexPath.row]
         print(url)
         print(images.count)
         cell.imageView.contentMode = .scaleAspectFit
         cell.imageView.image = images[indexPath.item]
         

         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
           
            return CGSize(width: 30, height: 30) // You can change width and height here as pr your requirement
        
        }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         4
     }
     
     
 }

 */
