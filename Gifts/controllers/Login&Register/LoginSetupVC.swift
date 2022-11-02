//
//  LoginSetupVC.swift
//  Gifts
//
//  Created by Apple on 30/05/22.
//

import UIKit

class LoginSetupVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    @IBAction func actionCreateAccount(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddressVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func actionSignIn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "loginVC")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
