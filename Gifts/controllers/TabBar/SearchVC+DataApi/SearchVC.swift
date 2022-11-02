//
//  SearchVC.swift
//  Gifts
//
//  Created by Apple on 01/06/22.
//

import UIKit


class SearchVC: BaseViewController,UISearchBarDelegate,UISearchTextFieldDelegate  {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
   
    
   
    var arrGiver = [GiverObj]() {
        didSet {
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
           
        }
    }
    var arrGetReceiverGift = [ReciverObj]() {
        didSet {
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
           
        }
    }
   
    let cellSpacingHeight: CGFloat = 10
    var GiftId : Int?
    var index : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearch.addPadding(.both(20))
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = 120
        self.tblView.showsHorizontalScrollIndicator = false
        self.tblView.showsVerticalScrollIndicator = false
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // getAllGifts()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        textField.resignFirstResponder()
//        if tfSearch.text == "" {
//           // arrGetGift.removeAll()
//            getAllGifts()
//            //self.tblView.reloadData()
//        }else{
//            arrGiver.removeAll()
//            tblView.reloadData()
//        }
//
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else { return true }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        print("newString",newString)
        let trimmedString = newString.trimmingCharacters(in: .whitespaces)
        if newString.count > 0 {
            getcards(searchTerm: trimmedString )
        }
        else{
            arrGiver.removeAll()
            arrGetReceiverGift.removeAll()
            tblView.reloadData()
        }
       
        return true
    }
    
    func getcards(searchTerm : String){
        let latitude = defaultValues.value(forKey: "latitude") ?? ""
        let longitude = defaultValues.value(forKey: "longitude") ?? ""
        var request = URLRequest(url: URL(string: "\(BaseViewController.Get_All_Gift)?q=\(searchTerm)&lat=\(latitude)&lng=\(longitude)")!,timeoutInterval: Double.infinity)
        
         let token =   UserStoreSingleton.shared.userToken
            print("Access Token --",token ?? "")
       
        request.addValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
 
        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
          guard let data = data else {
          // print(data)

            return
          }
            do {
                let responseModel = try JSONDecoder().decode(GetGiftModel.self, from: data)
                self.arrGiver = responseModel.giverObj  ?? []
                print(self.arrGiver)
                self.arrGetReceiverGift = responseModel.reciverObj ?? []
                print(arrGetReceiverGift)
                if self.arrGiver.count == 0 {
                    //tblView.isHidden = true
                  //  self.tblView.reloadData()
                }else{
                    DispatchQueue.main.async {
                      //  self.tblView.isHidden = false
                        self.tblView.reloadData()
                    }
                }
                if self.arrGetReceiverGift.count == 0 {
                    //tblView.isHidden = true
                  //  self.tblView.reloadData()
                }else{
                    DispatchQueue.main.async {
                      //  self.tblView.isHidden = false
                        self.tblView.reloadData()
                    }
                }

               } catch {
                       print(error)
                      // completed(.failure(.invalidData))
                 }
        }

        task.resume()
      
    }

}
extension SearchVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserStoreSingleton.shared.userType == "giver"{
            return  arrGiver.count
        }else{
            return  arrGetReceiverGift.count//imgArr.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:SearchTableCell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SearchTableCell
        if UserStoreSingleton.shared.userType == "giver"{
            cell.btnView.setTitle("Delete", for: .normal)
            cell.lblTitle.text = arrGiver[indexPath.row].title
            if arrGiver[indexPath.row].giftimages?.first?.image == "" {

            }else{
                let carImg = arrGiver[indexPath.row].giftimages?.first?.image
                cell.ProductImg.sd_setImage(with: URL(string: carImg ?? ""), placeholderImage: UIImage(named: "img1"))
            }
            cell.btnView.addTarget(self, action: #selector(deleteBtnPrsd), for: .touchUpInside)
            cell.btnView.tag = indexPath.row
          
        }else{
            cell.btnView.setTitle("View", for: .normal)
            cell.btnView.addTarget(self, action: #selector(viewBtnPrsd), for: .touchUpInside)
            cell.btnView.tag = indexPath.row
            if arrGetReceiverGift[indexPath.row].giftimages?.first?.image == "" {

            }else{
                let carImg = arrGetReceiverGift[indexPath.row].giftimages?.first?.image
                cell.ProductImg.sd_setImage(with: URL(string: carImg ?? ""), placeholderImage: UIImage(named: "img1"))
                cell.lblMiles.text = arrGetReceiverGift[indexPath.row].distance ?? "" 
            }
           
            cell.lblTitle.text = arrGetReceiverGift[indexPath.row].title
        }
        return cell
       }
    
       @objc func deleteBtnPrsd(sender: UIButton){
           print(sender.tag)
           index = sender.tag
           self.popupAlert(title: "From Me 2 U", message: "Are you sure, delete this Gift", actionTitles: ["Ok","Cancel"], actions:[{action1 in
               self.GiftId = self.arrGiver[sender.tag].id ?? 0
               print("GiftId",self.GiftId ?? 0)
               self.deleteGift()
              
           },{action2 in
               self.dismiss(animated: true, completion: nil)
           }, nil])
       }
       @objc func viewBtnPrsd(sender: UIButton){
        let objRef:DetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        objRef.productimg = arrGetReceiverGift[sender.tag].giftimages ?? []
        objRef.productTitle = arrGetReceiverGift[sender.tag].title ?? ""
        objRef.productDescp = arrGetReceiverGift[sender.tag].description ?? ""
        objRef.productMiles = arrGetReceiverGift[sender.tag].distance ?? ""
        self.navigationController?.pushViewController(objRef, animated: true)
       }
    // Set the spacing between sections
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }
       
       // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UserStoreSingleton.shared.userType == "giver" {
            let objRef:DetailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            objRef.productimg = arrGiver[indexPath.row].giftimages ?? []
            objRef.productTitle = arrGiver[indexPath.row].title ?? ""
            objRef.productDescp = arrGiver[indexPath.row].description ?? ""
            self.navigationController?.pushViewController(objRef, animated: true)
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
