//
//  TodoItemCell.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/14/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class TodoItemCell: UITableViewCell {

    @IBOutlet weak var todoItemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
