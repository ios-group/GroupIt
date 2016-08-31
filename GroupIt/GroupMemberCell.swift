//
//  GroupMemberCell.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/28/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class GroupMemberCell: UITableViewCell {

    
    @IBOutlet weak var groupMemberNameLabel: UILabel!
    
    var groupMember : User?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
