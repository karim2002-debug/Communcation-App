//
//  PostDetailsViewController.swift
//  Project communction app
//
//  Created by Macbook on 01/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class PostDetailsViewController: UIViewController  {
    
    
    
    
    //MARK: Variables
    
    var post : Post!
    
    var comments : [Comment] = []
    
     
    //MARK: outlet
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var LoaderCommentsView: NVActivityIndicatorView!
    @IBOutlet weak var  commentTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var PostTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var newCommentSV: UIStackView!
    
    
    // MARK: life Cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserManager.loggedInUser == nil{
            
            newCommentSV.isHidden = true
        }
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        backButton.layer.cornerRadius = backButton.frame.width / 2
        
        userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        
        PostTextLabel.text = post.text
        numberOfLikesLabel.text = String(post.likes)
        postImageView.SetImageFromStringUrl(StringUrl: post.image)
        if let imageUser = post.owner.picture{
            userImageView.SetImageFromStringUrl(StringUrl: imageUser)}
        
        userImageView.makeCircularImage()
        
        
        
            getPostComments()
        }
        
        
 

    // MARK: Action
    @IBAction func BackButton(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
    
    @IBAction func sendCommentButtonClicked(_ sender: Any) {
        
        let message = commentTextField.text!
        
        if let user = UserManager.loggedInUser{
            PostAPI.AddNewCommentToPost(postId: post.id, ownerID:user.id, message: message) {
                self.LoaderCommentsView.startAnimating()
                self.getPostComments()
                }
                
                self.commentTextField.text = ""
            }
        }
    
    
    // recover code
    func getPostComments(){
        
        PostAPI.getPostsComments(id:post.id) { commentResponse in
            self.LoaderCommentsView.startAnimating()

            self.comments = commentResponse
            self.commentTableView.reloadData()
            self.LoaderCommentsView.stopAnimating()
        
        
    }
}



}





extension PostDetailsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentcell", for: indexPath)as! CommentCell
        
        
        cell.commentMassageLabel.text = comments[indexPath.row].message
        cell.userNameLabel.text = comments[indexPath.row].owner.firstName + " " + comments[indexPath.row].owner.lastName
        
        // filing with image Commments
        
        
        if let user = comments[indexPath.row].owner.picture{
        cell.userimageView.SetImageFromStringUrl(StringUrl:user)
        }
        cell.userimageView.makeCircularImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
}


