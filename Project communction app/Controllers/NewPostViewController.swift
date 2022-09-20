//
//  NewPostViewController.swift
//  Project communction app
//
//  Created by Macbook on 16/09/2022.
//

import UIKit
import NVActivityIndicatorView
class NewPostViewController: UIViewController {

    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var postTextTextField: UITextView!
    @IBOutlet weak var postImageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addPostButtonClicked(_ sender: Any) {
        addButton.setTitle("", for: .normal) // to make magic UI and UX
        loaderView.startAnimating()
        if let user = UserManager.loggedInUser{
            PostAPI.AddNewPost(text: postTextTextField.text!, ownerID:user.id) {
                
                self.loaderView.stopAnimating()
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil , userInfo: nil)
                
                self.addButton.setTitle("Add", for: .normal) // to make magic UI and UX
                self.dismiss(animated: true)
               
        }
    }
    }
    
    @IBAction func closePageNewPost(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
