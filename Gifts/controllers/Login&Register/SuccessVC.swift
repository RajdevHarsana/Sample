//
//  SuccessVC.swift
//  Gifts
//
//  Created by Apple on 01/06/22.
//

import UIKit

class SuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    // MARK: - Navigation
    @IBAction func actionConfirm(_ sender: Any) {
        APPDELEGATE.configureTabbar()
    }
}
