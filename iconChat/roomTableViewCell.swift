//
//  roomTableViewCell.swift
//  iconChat
//
//  Created by 三坂真治 on 2019/07/26.
//  Copyright © 2019 shinji.misaka. All rights reserved.
//

import UIKit

class roomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var entryButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRoomData(_ roomData: RoomData) {
        
        self.roomNameLabel.text = "\(roomData.roomName!)"
        
        self.roomNumberLabel.text = "\(roomData.users.count)/\(roomData.number)"
        
        
    }
    
}
