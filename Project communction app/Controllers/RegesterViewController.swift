// break point work on which is work
//  RegesterViewController.swift
//  Project communction app
//
//  Created by Macbook on 14/09/2022.
//

import UIKit

class RegesterViewController: UIViewController {
    
    //MARK: OUTITLET
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNAmeTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func regesterButtonCilcked(_ sender: Any) {
        UserAPI.regesterNewUser(firstName: firstNameTextField.text!, lastName: lastNAmeTextField.text!, email: emailTextField.text!) 
                                    { userResponse, errorMessage in
            if errorMessage != nil{
                
                let alertError = UIAlertController(title: "error", message: errorMessage, preferredStyle: .alert)
                alertError.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alertError, animated: true)
            }else{
                let alertDone = UIAlertController(title: "Created Successfully", message: nil, preferredStyle: .alert)
                alertDone.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alertDone, animated: true)
            }
        }
                                }
    
    
    
    @IBAction func signInbuttonClicked(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController")as! SignInViewController
        
        present(vc, animated: true)
         
    }
    
}
