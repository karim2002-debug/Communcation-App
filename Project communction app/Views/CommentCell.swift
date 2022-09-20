//
//  CommentCell.swift
//  Project communction app
//
//  Created by Macbook on 02/09/2022.
//

import UIKit

class CommentCell: UITableViewCell {

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userimageView: UIImageView!
    
    @IBOutlet weak var commentMassageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
