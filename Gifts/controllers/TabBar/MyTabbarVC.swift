//
//  MyTabbarVC.swift
//  Gifts
//
//  Created by Apple on 30/05/22.
//

import UIKit

class MyTabbarVC: UITabBarController,UITabBarControllerDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowOpacity = 0.2
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        NotificationCenter.default.post(Notification(name: Notification.Name("Profile")))
        NotificationCenter.default.post(Notification(name: Notification.Name("notify")))
        NotificationCenter.default.post(Notification(name: Notification.Name("ChangePassword")))
      }
}



