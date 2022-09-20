//
//  UserAPI.swift
//  Project communction app
//
//  Created by Macbook on 14/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class UserAPI{
    
    static func getUserData(id :String , comletionHandler : @escaping (User)->()){
        
        
        let url = "https://dummyapi.io/data/v1/user/\(id)"
        let appId = "63237aaa605864fe3532a1b4"
        
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        AF.request(url , headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jsonData.rawData())
                comletionHandler(user)
                // self.setUserInfo()
            }
            catch let error {
                print(error)
            }
            
            print(jsonData)
            
            
            
        }
        
    }
    
    static func regesterNewUser(firstName : String ,lastName : String ,email : String,completionHandler : @escaping (User? , String?)->()){
        
        let url = "https://dummyapi.io/data/v1/user/create"
        let appId = "63237aaa605864fe3532a1b4"
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        let parmas = [
            
            "firstName":firstName,
            "lastName":lastName,
            "email":email 
            
        ]
        
        
        AF.request(url,method: .post,parameters: parmas,encoder: JSONParameterEncoder.default , headers: headers).validate() .responseJSON { response in
            
            switch response.result{
                
                // if request is success
            case .success:
                print("Success")
                let jsonData = JSON(response.value)
                print(jsonData )
                let decoder = JSONDecoder()
                do{
                    let user =   try decoder.decode(User.self, from: jsonData.rawData())
                    completionHandler(user , nil)
                }catch let error{
                    print(error)
                    
                }
                
                
            case .failure(let error):
             
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // errors messages
                let emailErorr = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                
                let errorMessage = firstNameError + " " + lastNameError + " " + emailErorr
                
               completionHandler(nil, errorMessage)
                
            }
            
            
        }
    }
    
    static func SignInUser(firstName : String ,lastName : String,completionHandler : @escaping (User? , String?)->()){
        
        let url = "https://dummyapi.io/data/v1/user"
        let appId = "63237aaa605864fe3532a1b4"
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        let parmas = [
            
            "created" : "1"
        ]
         
        AF.request(url,method: .get,parameters: parmas,encoder:URLEncodedFormParameterEncoder.default , headers: headers).validate().responseJSON { response in
            
            switch response.result{
                
                // if request is success
            case .success:
              
                let jsonData = JSON(response.value)
                let data = jsonData["data"]
                
                let decoder = JSONDecoder()
                do{
                    let users =   try decoder.decode([User].self, from: data.rawData())
            //        completionHandler(user , nil)
                    print(users)
                    
                    
                    var foundUser : User?
                    for user in users {
                        if user.firstName ==  firstName && user.lastName == lastName{
                            
                            foundUser = user
                            break
                        }
                        
                    }
                    
                    if let user = foundUser  {
                        completionHandler(user , nil)
                    }else{
                        completionHandler(nil,"The First Name or the Last Name Dont match any user")
                    }
                }catch let error{
                    print(error)
                    
                }
                  case .failure(let error):
             
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // errors messages
                let emailErorr = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                
                let errorMessage = firstNameError + " " + lastNameError + " " + emailErorr
                
               completionHandler(nil, errorMessage)
                
            }
            
            
        }
    }
    
    
    
    static func UpdataUser(userId : String ,firstName : String ,phone : String,imageUrl : String,completionHandler : @escaping (User? , String?)->()){
        
        let url = "https://dummyapi.io/data/v1/user/\(userId)"
        let appId = "63237aaa605864fe3532a1b4"
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        let parmas = [
            
            "firstName" : firstName,
            "phone" : phone,
            "picture" : imageUrl
            
        ]
         
        AF.request(url,method: .put,parameters: parmas,encoder:JSONParameterEncoder.default , headers: headers).validate().responseJSON { response in
            
            switch response.result{
                
                // if request is success
            case .success:
              
                let jsonData = JSON(response.value)
               // let data = jsonData["data"]
                
                let decoder = JSONDecoder()
                do{
                    let user =   try decoder.decode(User.self, from: jsonData.rawData())
               completionHandler(user , nil)
                    print(user)
                    
                    
                }catch let error{
                    print(error)
                    
                }
                  case .failure(let error):
             
                let jsonData = JSON(response.data)
                let data = jsonData["data"]
                
                // errors messages
                let emailErorr = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                
                let errorMessage = firstNameError + " " + lastNameError + " " + emailErorr
                
               completionHandler(nil, errorMessage)
                
            }
            
            
        }
    }
    
}
