//
//  GroupsCell.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupsCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    
    var groupDetails: Group! {
        didSet{
            groupNameLabel.text = groupDetails.groupName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
