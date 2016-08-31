//
//  GroupsCell.swift
//  GroupIt
//
//  Created by Rajiv Deshmukh on 8/13/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
protocol GroupCellDelegate {
    func onLongPress(group : Group)
}

class GroupsCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    
    var delegate : GroupCellDelegate?
    
    var group: Group! {
        didSet{
            groupNameLabel.text = group.groupName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .DisclosureIndicator
        // Initialization code
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressGroupCell))
        longPressGestureRecognizer.delegate = self
        self.addGestureRecognizer(longPressGestureRecognizer)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func onLongPressGroupCell() {
        print("on long press ... ")
        self.delegate?.onLongPress(self.group!)
    }

}
