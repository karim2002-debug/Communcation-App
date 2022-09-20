//
//  ViewController.swift
//  Project communction app
//
//  Created by Macbook on 31/08/2022.
//

import UIKit
 
import NVActivityIndicatorView
class PostsViewController: UIViewController {
    
    
    
    var posts : [Post] = []
    
    var page = 0
    
    // total of the number of posts
    var total = 0
    @IBOutlet weak var statesView: UIView!
    
    @IBOutlet weak var newPostView: UIView!
    
    @IBOutlet weak var wellcomeLabel: UILabel!
    @IBOutlet weak var postsTableView: UITableView!
    
    @IBOutlet weak var LoaderView: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserManager.loggedInUser == nil{
             
        }
        
        
        // to add the new post after click on add
        NotificationCenter.default.addObserver(self, selector: #selector(addNewPost), name: NSNotification.Name("NewPostAdded"), object: nil)
        
        
        
        
    // check if user loggedin or gust
        
        if let user = UserManager.loggedInUser{
            wellcomeLabel.text = "Hi, \(user.firstName)"
        }else{
            wellcomeLabel.text = "Visitor"
            newPostView.isHidden = true
             
        }
        
        // Notifactioin of Stack User View
        NotificationCenter.default.addObserver(self, selector: #selector(userProfileTapped), name: NSNotification.Name("UserStackViewTapped"), object: nil)
        
        
        
        
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        
        
        // Request APIof posts
 
        getPost()
        
        }
        
        
    @objc func addNewPost(){
        self.posts = []
        self.page = 0 
        getPost()
    }
       
    
    
    func getPost(){
        
        LoaderView.startAnimating()
        PostAPI.getAllPost(page: page) { postsResponse,total in
            self.total = total
            self.posts.append(contentsOf: postsResponse)
            self.postsTableView.reloadData()
            self.LoaderView.stopAnimating()
        
    }
    }
    
    
    @IBAction func LogOutButton(_ sender: Any) {
        
        if let user = UserManager.loggedInUser  {
            let alert = UIAlertController(title: "Hi \(user.firstName)", message: "Are you sure of logging out", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { alert in
                
               // self.dismiss(animated: true)
                UserManager.loggedInUser = nil 
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegesterViewController")as! RegesterViewController
                self.present(vc, animated: true)
                
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            present(alert, animated: true)
        }else{
           
            let alertSignIn = UIAlertController(title: "Sign In", message: "Are you sure sign in", preferredStyle: .alert)
            alertSignIn.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
                
                self.dismiss(animated: true)
            
            }))
            alertSignIn.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            present(alertSignIn, animated: true)
            
             
        }
        
        
        
    }
    
    @objc func userProfileTapped(notifaction : Notification){
        
        if let cell = notifaction.userInfo?["cell"] as? UITableViewCell {
            
            if let indexPath =  postsTableView.indexPath(for: cell){
                
                let post = posts[indexPath.row]
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "userprofile")as! ProfileViewController
                
                vc.user = post.owner
                
                present(vc, animated: true, completion: nil)
            }
            
            
        }
        
        
        
        
    }
    
}




extension PostsViewController : UITableViewDelegate , UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
        
        
        // filling the posts
        cell.postTextLabel.text = posts[indexPath.row].text
        
        
        // to convert image(String) to UIImage to the post image
        
        cell.postImageView.SetImageFromStringUrl(StringUrl: posts[indexPath.row].image)
        
        
        
        
        
        
        
        // User profile Image
        
        let userImage = posts[indexPath.row].owner.picture
        
        if let image = userImage{
        cell.userImageView.SetImageFromStringUrl(StringUrl: userImage!)
        }else{
            cell.userImageView.image = UIImage(systemName: "person")
        }
        
        cell.userImageView.makeCircularImage()
        // filling the user data
        cell.postNameLabel.text = "\(posts[indexPath.row].owner.firstName)  \( posts[indexPath.row].owner.lastName)"
        
        
        
        
        
        
        // filing NUmber of likes
        
        cell.NumberOfLikes.text = String(posts[indexPath.row].likes)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "postDetalsViewController")as! PostDetailsViewController
        
        
        vc.post = selectedPost
        
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == posts.count - 1 && posts.count < total{
            page = page + 1
            
            getPost() 
            
        }
     }
    
    

    
}
