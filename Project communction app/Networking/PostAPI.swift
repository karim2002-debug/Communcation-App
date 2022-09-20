//
//  PostAPI.swift
//  Project communction app
//
//  Created by Macbook on 14/09/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class PostAPI{
    
    static func getAllPost(page : Int , completionHandler : @escaping ([Post],Int)->() ){
        
        let url = "https://dummyapi.io/data/v1/post"
        let appId = "63237aaa605864fe3532a1b4"
        
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        let parmes = [
            "page":"\(page)",
            "limit":"5"
        ]
        
        AF.request(url ,parameters: parmes,encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            let total = jsonData["total"].intValue
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                completionHandler(posts,total)
                
            }
            catch let error {
                print(error)
            }
            
            print(data)
            //print(jsonData)
        }
    
    }
    
    static func getPostsComments(id : String, completionHandler : @escaping ([Comment])->()){
        
        
        let url = "https://dummyapi.io/data/v1/post/\(id)/comment"
        let appId = "63237aaa605864fe3532a1b4"
        let headers : HTTPHeaders = [
            "app-id" : appId
        ]
        
        AF.request(url , headers: headers).responseJSON { response in
            let jsonData = JSON(response.value)
            let data = jsonData["data"]
            
            
            let decoder = JSONDecoder()
            do{
                
               let comments  = try decoder.decode([Comment].self, from: data.rawData())
                completionHandler(comments)
            }catch let error{
                
                print(error)
                
            }
            
            
        }
        
        
        
    }
    
    // MARK: COMMENT API
    
    
    static func AddNewCommentToPost(postId : String ,ownerID : String ,message : String,completionHandler : @escaping ()->()){
        
        let url = "https://dummyapi.io/data/v1/comment/create"
        let appId = "63237aaa605864fe3532a1b4"
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        let parmas = [
            
            "post":postId,
            "owner":ownerID,
            "message":message
            
        ]
        AF.request(url,method: .post,parameters: parmas,encoder: JSONParameterEncoder.default , headers: headers).validate() .responseJSON { response in
            
            switch response.result{
                
                // if request is success
            case .success:
                print("Success")
                completionHandler()
            
            case .failure(let error):
             print(error )
                
            }
            
            
        }
    }

    
    // MARK: TAGS API
    static func getAlltags(completionHandler : @escaping ([String])->() ){
        
        let url = "https://dummyapi.io/data/v1/tag"
        let appId = "63237aaa605864fe3532a1b4"
        
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        AF.request(url , headers: headers).responseJSON { response in
            let jsonData = JSON(response.data)
            let data = jsonData["data"]
             
             
            let decoder = JSONDecoder()
            do {
               
                
                 
                let tags = try decoder.decode([String].self, from: data.rawData())
                        completionHandler(tags)
               
               
                
            }
            catch let error {
                print(error)
            }
            
            print(data)
            //print(jsonData)
        }
    
    }
    
    
    static func AddNewPost(text : String  ,ownerID : String,completionHandler : @escaping ()->()){
        
        let url = "https://dummyapi.io/data/v1/post/create"
        let appId = "63237aaa605864fe3532a1b4"
        let headers : HTTPHeaders = [
            
            "app-id" : appId
        ]
        
        let parmas = [
            
            "text":text,
            "owner":ownerID,
           // "image":imageUrl
            
        ]
        AF.request(url,method: .post,parameters: parmas,encoder: JSONParameterEncoder.default , headers: headers).validate() .responseJSON { response in
            
            switch response.result{
                
                // if request is success
            case .success:
                print("Success")
                completionHandler()
            
            case .failure(let error):
             print(error )
                
            }
            
            
        }
    }

    
}
