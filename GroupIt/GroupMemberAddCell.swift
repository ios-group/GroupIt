//
//  GroupMemberAddCellTableViewCell.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/29/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol GroupMemberAddCellDelegeate {
    func onAddUser(user : User)
}

class GroupMemberAddCell: UITableViewCell {

    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var user : User?
    var delegate : GroupMemberAddCellDelegeate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onAddButtonTap(sender: AnyObject) {
        delegate?.onAddUser(user!)
    }
}
