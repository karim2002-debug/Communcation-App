//
//  Comment.swift
//  Project communction app
//
//  Created by Macbook on 02/09/2022.
//

import Foundation


struct Comment : Decodable{
    
    var id : String
    var message : String
    var owner : User
    
}
