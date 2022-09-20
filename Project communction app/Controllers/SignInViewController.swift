//
//  SignInViewController.swift
//  Project communction app
//
//  Created by Macbook on 14/09/2022.
//

import UIKit
import Spring

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInLabel: SpringLabel!
    
    @IBOutlet weak var skipButton: SpringButton!
    @IBOutlet weak var regesterButton: SpringButton! // for animation
    @IBOutlet weak var signInButton: SpringButton!  // for animation
    @IBOutlet weak var firstNameTextField: SpringTextField!
    
    @IBOutlet weak var lastNameTextField: SpringTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTextField.text = "karim"
        lastNameTextField.text = "tawfiq"
        // Do any additional setup after loading the view.
        
        animatIn()
        
        
    }
    
    
    
    
    
    // animation with sping libarary
    func animatIn(){
        
        firstNameTextField.animation = "fadeInRight"
        firstNameTextField.delay = 0.5
        firstNameTextField.duration = 2
        firstNameTextField.animate()
        
        lastNameTextField.animation = "fadeInLeft"
        lastNameTextField.delay = 0.9
        lastNameTextField.duration = 2
        lastNameTextField.animate()
        
        signInButton.animation = "zoomIn"
        signInButton.delay = 1.4
        signInButton.duration = 2
        signInButton.animate()
        
        
        regesterButton.animation = "zoomIn"
        regesterButton.delay = 1.8
        regesterButton.duration = 2
        regesterButton.animate()
        
        skipButton.animation = "zoomIn"
        skipButton.delay = 2
        skipButton.duration = 2
        skipButton.animate()
        
        signInLabel.animation = "fadeInRight"
        signInLabel.delay = 2
        signInLabel.duration = 2
        signInLabel.animate()
    }
    
    
    
    // this animation do when you clicked the button
    // its the 3akss the animatIn()
    func animatOut(user : User?){
        
        firstNameTextField.animation = "fadeInRight"
        firstNameTextField.delay = 0.5
        firstNameTextField.duration = 2
        firstNameTextField.animateTo()
        
        lastNameTextField.animation = "fadeInLeft"
        lastNameTextField.delay = 0.9
        lastNameTextField.duration = 2
        lastNameTextField.animateTo()
        
        signInButton.animation = "zoomIn"
        signInButton.delay = 1.4
        signInButton.duration = 2
        signInButton.animateTo()
        
        
        regesterButton.animation = "zoomIn"
        regesterButton.delay = 1.8
        regesterButton.duration = 2
        regesterButton.animateTo()
        
        skipButton.animation = "zoomIn"
        skipButton.delay = 2
        skipButton.duration = 2
        skipButton.animateTo()
        
        signInLabel.animation = "fadeInRight"
        signInLabel.delay = 2
        signInLabel.duration = 2
        signInLabel.animateToNext {
            
            
            if let loggedInUser = user{
                
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainTabBar")
                
                
                
                UserManager.loggedInUser = loggedInUser
                
                self.present(vc!, animated: true)
                
                
            }
        }
    }
    
    @IBAction func SignInButtonClicked(_ sender: Any) {
        
        
        UserAPI.SignInUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { userResponse, errorMessage in
            
            if let Message = errorMessage {
                
                let alert = UIAlertController(title: "error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"Okay", style: .default, handler: nil))
                self.present(alert, animated: true)
            }else{
                
                
                
                
                self.animatOut(user : userResponse)
                
                
                
                
            }
            
        }
        
        
        
    }
    
}





