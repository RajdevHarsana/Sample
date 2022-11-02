//
// CountryModel.swift
//  Uber-Driver
//
//  Created by Krishan Lal on 2/15/19.
//  Copyright © 2019 Krishan Lal. All rights reserved.
//
    
    import Foundation
    import UIKit

    var countryList = [CountryModel]()
    class CountryModel {
        
        
        var countryName = String()
        var isoCode = String()
        var callingCode = String()
        var countryFlag = String()
        
        
        func setCountryData(dict:[String:String]){
            
            self.countryName = dict["Name"]!
            self.isoCode = dict["ISO"]!
            self.callingCode = dict["Code"]!
            self.countryFlag = flag(country: dict["ISO"]!.uppercased())
            
        }
        
        func flag(country:String) -> String {
            let base : UInt32 = 127397
            var s = ""
            for v in country.unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return String(s)
        }
        
    }


