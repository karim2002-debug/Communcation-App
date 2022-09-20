//
//  Post.swift
//  Project communction app
//
//  Created by Macbook on 01/09/2022.
//

import Foundation

import UIKit

struct Post : Decodable{
    
    var id : String
    var image : String
    var likes : Int
    var text : String
    var owner : User
}
