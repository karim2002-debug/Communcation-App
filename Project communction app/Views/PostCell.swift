//
//  PostCell.swift
//  Project communction app
//
//  Created by Macbook on 01/09/2022.
//

import UIKit

class PostCell: UITableViewCell {

    
    @IBOutlet weak var UserStackView: UIStackView!{
        didSet{
            UserStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userStackViewTapped)))
            
            
            
        }
     }
    
    
    @IBOutlet weak var backView: UIView!{
        didSet{
            backView.layer.shadowColor = UIColor.gray.cgColor
            backView.layer.shadowOpacity = 0.4
            backView.layer.shadowOffset = CGSize(width: 0, height: 10)
            backView.layer.cornerRadius = 7
        }
    }
    
    
    @IBOutlet weak var NumberOfLikes: UILabel!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    // MARK: actions
    
    @objc func userStackViewTapped(){
        
        NotificationCenter.default.post(name: NSNotification.Name("UserStackViewTapped"), object:self ,userInfo:["cell":self])
        
    }

}
