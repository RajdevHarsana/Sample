
//
// CountryViewModel.swift
//  Uber-Driver
//
//  Created by Krishan Lal on 2/15/19.
//  Copyright © 2019 Krishan Lal. All rights reserved.
//

import Foundation


class CountryViewModel{
    
    var filterArray = [CountryModel]()
    
    init() {
        
        filterArray = countryList
    }
    
    func prepareCountryList(){
        countryList.removeAll()
        for dict in countryArray{
            
            let obj = CountryModel()
            obj.setCountryData(dict: dict)
            countryList.append(obj)
        }
        filterArray = countryList
    }
    
    
    func searchTextChange(txt:String){
        //self.filterArray.removeAll()
        self.filterArray = countryList.filter({ (model) -> Bool in
            (model.countryName.lowercased().contains(txt.lowercased()))
        })
        
    }
    
    
    
    func searchDidCancel(){
        
        self.filterArray = countryList
    }
    
    
    func numberOfRows()->Int{
        
        return filterArray.count
    }
    
    func getCountryFlag(index:Int)->String{
        
        let obj = filterArray[index]
        return obj.countryFlag
    }
    
    func getCountryNameAt(index:Int)->String{
        
        let obj = filterArray[index]
        return obj.countryName
    }
    
    func getSelectedCountry(index:Int)->CountryModel{
        
        
        let obj = filterArray[index]
        return obj
    }
    
    
    
}
    
