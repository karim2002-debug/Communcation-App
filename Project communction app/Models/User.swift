//
//  User.swift
//  Project communction app
//
//  Created by Macbook on 01/09/2022.
//

import Foundation
import UIKit

struct User : Decodable{
    
    var id : String
    var firstName : String
    var lastName : String
    var picture : String?
    var gender : String?
    var email : String?
    var phone : String?
    var location : Location?

}
