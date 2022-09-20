//
//  ProfileViewController.swift
//  Project communction app
//
//  Created by Macbook on 06/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON


class ProfileViewController: UIViewController {

    //MARK: OUTLETS
    
    
    
    var user : User!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var emaiLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserInfo()
        
        
        
        
        // API of User Data
        UserAPI.getUserData(id: user.id) { userResponse in
            self.user = userResponse
            self.setUserInfo()
        }
        
 
        
        
    }
    
    func setUserInfo(){
        userImageView.SetImageFromStringUrl(StringUrl: user.picture!)
        userImageView.makeCircularImage()
        userNameLabel.text = user.firstName + " " + user.lastName
        
        phoneLabel.text = user.phone
        emaiLabel.text = user.email
        genderLabel.text = user.gender
        if let location = user.location{
            countryLabel.text = location.country + " _ " + location.city
        }
    }
    

}
