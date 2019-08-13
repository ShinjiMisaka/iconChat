//
//  PostTableViewCell.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/30.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var nameTextLabel: UILabel!
    @IBOutlet weak var uidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
        
        self.iconImageView.image = postData.image
        
        self.commentTextLabel.text = "\(postData.comment!)"
        
        self.nameTextLabel.text = "\(postData.name!)"
        
        self.uidLabel.text = "\(postData.uid!)"
       
    }
    
}
