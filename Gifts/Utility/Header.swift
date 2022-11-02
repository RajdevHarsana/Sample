//
//  Header.swift
//  Stay Home
//
//  Created by GANESH on 02/06/20.
//  Copyright © 2020 Apptunix. All rights reserved.
//

import Foundation
import UIKit

let KMainStoryBoard = UIStoryboard.init(name:"Main", bundle: nil)
let mainStoryboard = Storyboards.Main.get
let HomeStoryBoard = Storyboards.HomeStoryboard.get
let OrdersStoryBoard = Storyboards.Orders.get
let SideMenuStoryBoard = Storyboards.SideMenu.get
let UntitledSectionStoryBoard = Storyboards.UntitledSection.get
let FiveStoryboard = Storyboards.Five.get



@available(iOS 13.0, *)
var appDelegate = UIApplication.shared.delegate as! AppDelegate

let DEVICE_SIZE = UIScreen.main.bounds
let DEVICE_HEIGHT = DEVICE_SIZE.height
let DEVICE_WIDTH = DEVICE_SIZE.width
@available(iOS 13.0, *)
let APPDELEGATE = (UIApplication.shared.delegate as! AppDelegate)

enum Storyboards : String {
    
    case Main
    case HomeStoryboard
    case Orders
    case SideMenu
    case UntitledSection
    case Five
    
    var get:UIStoryboard
    {
        let sb  = UIStoryboard.init(name: self.rawValue, bundle: nil)
        return  sb
    }
 }


struct Color {
    //static let blue = UIColor.init(named: "Button")!
    static let darkBlue = UIColor.init(named: "DarkBlue")!
    //static let purple = UIColor.init(named: "Purple")!

}


