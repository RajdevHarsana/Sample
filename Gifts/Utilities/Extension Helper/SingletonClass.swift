//
//  SingletonClass.swift
//  Gifts
//
//  Created by Apple on 12/09/18.
//  Copyright © 2018 possibilitySolution. All rights reserved.
//
import UIKit

class Singleton {
    
    var latitude : Double = 0.0
    var longitude : Double = 0.0
    var address : String = ""
   
    class var sharedInstance : Singleton {
        struct Static {
            static let instance : Singleton = Singleton()
        }
        return Static.instance
    }
    var Latitude : Double {
        get{
            return self.latitude
        }
        set {
            self.latitude = newValue
        }
    }
    var Longitude : Double {
        
        get{
            return self.longitude
        }
        set {
            self.longitude = newValue
        }
    }
    var Address : String {
        
        get{
            return self.address
        }
        set {
            self.address = newValue
        }
    }
}

