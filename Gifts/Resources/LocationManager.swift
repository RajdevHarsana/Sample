//
//  LocationManager.swift
//  YoomApplication
//
//  Created by sandeep on 10/01/22.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

public protocol LocationManagerDelegate : AnyObject{
  //  func currentLocation(coordinates : CLLocationCoordinate2D)
    func  currentLocation(coordinates : CLLocationCoordinate2D, address: String)
}


open class LocationManager : NSObject{
    var locationDelegate : LocationManagerDelegate?
    private var locationManager = CLLocationManager()
    private var presentationController : UIViewController?
    static let shared = LocationManager()
        
    public init(controller : UIViewController,locationDelegate : LocationManagerDelegate) {
        super.init()
        self.locationDelegate = locationDelegate
        self.locationManager.delegate = self
        self.locationManager.requestLocation()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.presentationController = controller
    }
    public override init() {}
    func stopUpdatingLocations(){
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
    }
    
    func getCurrentAddressFromGoogleMap(with coordinates:CLLocationCoordinate2D, completion : @escaping(_ : String) -> Void){
        Loader.start()
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinates) { response, error in
            Loader.stop()
            if error != nil {
              print("reverse geodcode fail: \(error!.localizedDescription)")
            } else {
              guard let places = response?.results(),
                 let place = places.first,
                 let lines = place.lines else {
                completion("error in fetching location")
                return
              }
              print("place-----", place)
              print("lines---->", lines.joined(separator: ","))
                let address = "\(lines.joined(separator: ",")) \(place.locality ?? "")"
              completion(address)
               
         //     self.usercurrentAddress = address
            }
        }
    }
        
    
    func getCurrentAddress(with coordinates:CLLocationCoordinate2D, completion : @escaping(_ : String) -> Void){
        
        Loader.start()
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { (placemarks, error) in
            Loader.stop()
            if (error != nil){
                print("error in reverseGeocode")
                completion("error in fetching location")
            }else{
                let placemark = placemarks! as [CLPlacemark]
                if placemark.count>0{
                    let placemark = placemarks![0]
                    print(placemark.locality)
                    print(placemark.administrativeArea!)
                    print(placemark.country!)
                    completion("\(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.country ?? "")")
                }else{
                    completion("error in fetching location")
                }
            }
        }
    }
}

extension LocationManager : CLLocationManagerDelegate{
//    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let loc = locations.last{
//            self.locationDelegate?.currentLocation(coordinates: loc.coordinate)
//            self.getCurrentAddressFromGoogleMap(with: loc.coordinate) { (address) in
//                self.locationDelegate?.currentLocation(coordinates: loc.coordinate)
//            }
//            self.stopUpdatingLocations()
//        }
//    }
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let loc = locations.last{
            //self.locationDelegate?.currentLocation(coordinates: loc.coordinate)
            self.getCurrentAddressFromGoogleMap(with: loc.coordinate) { (address) in
                self.locationDelegate?.currentLocation(coordinates: loc.coordinate, address: address)
            }
            self.stopUpdatingLocations()
        }
    }
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            break
        case .notDetermined:
            self.locationManager.requestLocation()
            self.locationManager.requestWhenInUseAuthorization()
        default:
            self.locationManager.stopUpdatingLocation()
            let aC = UIAlertController(title: "Location is turned off", message: "Please enable the location from privacy section ", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Open", style: .default) { (clicked) in
                self.presentationController?.OpenSettings()
            }
            aC.addAction(okAction)
            self.presentationController?.present(aC, animated: true, completion: nil)
            break
        }
    }
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension UIViewController{
    func OpenSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: { _ in
                // Handle
            })
        }
    }
}
