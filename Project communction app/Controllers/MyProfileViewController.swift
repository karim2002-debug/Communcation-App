//
//  MyProfileViewController.swift
//  Project communction app
//
//  Created by Macbook on 17/09/2022.
//

import UIKit
import NVActivityIndicatorView
class MyProfileViewController: UIViewController {

    
    //MARK: OUTLITS
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var imageTexfield: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.makeCircularImage()
        setUpUi()

        }
        
    func setUpUi(){
        
        if let user = UserManager.loggedInUser{
            if let image = user.picture{
                userImageView.SetImageFromStringUrl(StringUrl: image)
            }
            
            nameLabel.text = user.firstName + " " + user.lastName
            firstNameTextField.text = user.firstName
            
            phoneTextField.text = user.phone 
    
            imageTexfield.text = user.picture
            
        }
        
        
    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        
        loaderView.startAnimating()
        guard let loggedInUser = UserManager.loggedInUser else{return}
        UserAPI.UpdataUser(userId: loggedInUser.id, firstName: firstNameTextField.text!, phone: phoneTextField.text!, imageUrl: imageTexfield.text!) { user, messageError in
            if let responeUser = user{
                if let  image = user?.picture{
                    self.userImageView.SetImageFromStringUrl(StringUrl: image)
                    
                }
                self.nameLabel.text = responeUser.firstName + " " + responeUser.lastName
                self.phoneTextField.text = responeUser.phone
            }
           
            self.loaderView.stopAnimating()
        }
        
    }
    
    
}
    
