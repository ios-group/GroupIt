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
    
    @IBOutlet weak var noOfUsersLabel: UILabel!
    @IBOutlet weak var noOfCategoriesLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    var delegate : GroupCellDelegate?
    
    var group: Group! {
        didSet{
            groupNameLabel.text = group.groupName
            
            if group.groupMembers?.count != 0  {
                noOfUsersLabel.text = String (group.groupMembers!.count)
            }else {
                noOfUsersLabel.text = "0"
            }
            
            if group.categories?.count != 0 {
                noOfCategoriesLabel.text = String (group.categories!.count)
            }else {
                noOfCategoriesLabel.text = "0"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .DisclosureIndicator
        self.backgroundColor = ColorTheme.GROUPS_TABLE_BACKGROUND_COLOR

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
