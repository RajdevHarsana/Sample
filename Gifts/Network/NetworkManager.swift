//
//  NetworkManager.swift
//  YoomApplication
//
//  Created by sandeep on 03/01/22.
//

import Foundation
import Alamofire

public typealias parameters = [String: Any]

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
class NetworkManager:NSObject{
    static let shared = NetworkManager()
    
    func UploadDocumentWithParameters<T:Decodable>(type:T.Type,image: Data?, withName: String, fileName: String, api:EndPoint, params: [String: Any]?,completionHandler : @escaping (Bool, T?) -> Void) {
        var header:HTTPHeaders?
        
        Loader.start()
        
        let userData = Global.objGlobalMethod.loadUserData_UserDefaults(userLoginData: user_LoginData)
        let token = userData?.token ?? ""
        
        header = [
            "authorization": token,
            "Accept": "application/json"
        ]
       
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params ?? [:] {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
           if image != nil{
                multiPart.append(image!, withName: withName, fileName: fileName, mimeType: "application/*")
           }
           
        }, to: api.path,
           method: .post, headers: header)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success:
                    print(response)
                    Loader.stop()
                    if( response.data != nil){
                        do {
                            let value = try JSONDecoder().decode(type, from: response.data!)
                            completionHandler(true,value)
                        }catch let error as NSError{
                            print(error)
                        }
                    }
                    break
                case .failure( let error):
                    print(error.localizedDescription)
                    Loader.stop()
                    completionHandler(false,nil)
                }
                
                
                //Do what ever you want to do with response
            })
    }
    
    
    func UploadImageWithParameters<T:Decodable>(type:T.Type,image: Data?, api:EndPoint, params: [String: Any]?,completionHandler : @escaping (Bool, T?) -> Void) {
        var header:HTTPHeaders?

        Loader.start()

       // if let userLoginData = UserDefaults.standard.object(SignUserData.self, with: user_LoginData)  {
            if let token =    UserStoreSingleton.shared.userToken {
                header = [
                    "authorization": token,
                    "Accept": "application/json"
                ]
            }
            else {
                DisplayBanner.show(message: "Token not accessible")
            }

        AF.upload(multipartFormData: { multiPart in
            for (key, value) in params ?? [:] {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multiPart.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multiPart.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
           if image != nil{
                multiPart.append(image!, withName: "image", fileName: "file.png", mimeType: "image/png")
           }

        }, to: api.path,
           method: .post, headers: header)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { response in
              switch response.result {
                case .success:
                    print(response)
                    Loader.stop()
                    if( response.data != nil){
                        do {
                            let value = try JSONDecoder().decode(type, from: response.data!)
                            completionHandler(true,value)
                        }catch let error as NSError{
                            print(error)
                        }
                    }
                    break
                case .failure( let error):
                    print(error.localizedDescription)
                    Loader.stop()
                    completionHandler(false,nil)
                }
            })
    }
    func fetch<T:Decodable>(type:T.Type, httpMethod:HTTPMethod, isAutorization: Bool , api:EndPoint,parameter : [String:Any]?,completionHandler : @escaping (Bool, T?) -> Void){
        
        var header = HTTPHeaders()
        //header = nil
        Loader.start()
        if isAutorization {
           // if let userLoginData = UserDefaults.standard.object(SignUserData.self, with: user_LoginData)  {
                if let token =    UserStoreSingleton.shared.userToken {
                    print("Access Token --",token)
                    header = [
                        "authorization": "Bearer \(token)",
                        "Accept": "application/json"
                    ]
                }
                else {
                    DisplayBanner.show(message: "Token not accessible")
                }
         
        }
        var param = parameter
        if let loader = parameter?["loader"] as? Bool {
            if !loader {
                Loader.stop()
            }
        }
        print("API Url --> ", api.path)
        print("Params --> ", parameter ?? [String: Any]())
        
        if httpMethod == .get {
            param = nil
        }
       
        AF.request(api.path, method: httpMethod, parameters: param,encoding: JSONEncoding.default, headers: header).responseJSON {
                   response in
            print("response",response)
            Loader.stop()
            switch response.result {
            case .success:
                print(response)
                if response.response?.statusCode == 403 {
                    print("Seestion Expire")
                
                        //self.SessionExpire(message: "Your session expire. Please login again.")
                    return
                }
                if response.response?.statusCode == 200 {
                    if response.value != nil {
                        if let dicValue = response.value as? [String: Any] {
                            if let statusCode = dicValue["status"] as? Int {
                                print(statusCode)
                                if statusCode == 200 {
                                    do {
                                        if let data = response.data{
                                            let value = try JSONDecoder().decode(type.self, from: data)
                                           completionHandler(true,value)
                                        }
                                    }catch let error as NSError{
                                        print(error)
                                        self.AlertOnWindow(message: error.localizedDescription)
                                    }
                                }
                                else {
                                    self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessages.somethingWentWrong)
                                }
                            }
                        }
                    }
                }
                else {
                    if let dicValue = response.value as? [String: Any] {
                        self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessages.somethingWentWrong)
                    }
                    else {
                        self.AlertOnWindow(message: ErrorMessages.somethingWentWrong)
                    }
                    
                }
                break
            case .failure(let error):
                completionHandler(false,nil)
                self.AlertOnWindow(message: error.localizedDescription)
            }
        }
    }
    func fetchs<T:Decodable>(type:T.Type, httpMethod:HTTPMethod, isAutorization: Bool , api:EndPoint,parameter : [String:Any]?,completionHandler : @escaping (Bool, T?) -> Void){
        
        var header = HTTPHeaders()
        //header = nil
      //  Loader.start()
        if isAutorization {
           // if let userLoginData = UserDefaults.standard.object(SignUserData.self, with: user_LoginData)  {
                if let token =    UserStoreSingleton.shared.userToken {
                    print("Access Token --",token)
                    header = [
                        "authorization": "Bearer \(token)",
                        "Accept": "application/json"
                    ]
                }
                else {
                   // DisplayBanner.show(message: "Token not accessible")
                }
         
        }
        
        
        var param = parameter
        if let loader = parameter?["loader"] as? Bool {
            if !loader {
                Loader.stop()
            }
        }
        
     
        print("API Url --> ", api.path)
        print("Params --> ", parameter ?? [String: Any]())
        
        if httpMethod == .get {
            param = nil
        }
       
        AF.request(api.path, method: httpMethod, parameters: param,encoding: JSONEncoding.default, headers: header).responseJSON {
                   response in
            print("response",response)
            Loader.stop()
            switch response.result {
            case .success:
                print(response)
                if response.response?.statusCode == 403 {
                    print("Seestion Expire")
                
                        //self.SessionExpire(message: "Your session expire. Please login again.")
                    return
                }
                if response.response?.statusCode == 200 {
                    if response.value != nil {
                        if let dicValue = response.value as? [String: Any] {
                            if let statusCode = dicValue["status"] as? Int {
                                print(statusCode)
                                if statusCode == 200 {
                                    do {
                                        if let data = response.data{
                                            let value = try JSONDecoder().decode(type.self, from: data)
                                           completionHandler(true,value)
                                        }
                                    }catch let error as NSError{
                                        print(error)
                                      //  self.AlertOnWindow(message: error.localizedDescription)
                                    }
                                }
                                else {
                                   // self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessages.somethingWentWrong)
                                }
                            }
                        }
                    }
                }
                else {
                    if let dicValue = response.value as? [String: Any] {
                       // self.AlertOnWindow(message: dicValue["message"] as? String ?? ErrorMessages.somethingWentWrong)
                    }
                    else {
                       // self.AlertOnWindow(message: ErrorMessages.somethingWentWrong)
                    }
                    
                }
                break
            case .failure(let error):
                completionHandler(false,nil)
               // self.AlertOnWindow(message: error.localizedDescription)
            }
        }
    }

    func AlertOnWindow(message: String) {
        let window = UIApplication.shared.windows.first
        let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        
        if window?.rootViewController?.presentedViewController==nil{
            window?.rootViewController?.present(alert, animated: true, completion: nil)
        }else{
            window?.rootViewController?.presentedViewController!.present(alert, animated: true, completion: nil)
        }
        //window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    func SessionExpire(message: String) {
        let window = UIApplication.shared.windows.first
        let alert = UIAlertController(title: "Alert!!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            Global.objGlobalMethod.ClearLoginData()
        }))
        // show the alert
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}



