//
//  CategoryCell.swift
//  GroupIt
//
//  Created by Saumeel Gajera on 8/16/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol CategoryCellDelegate {
    func onLongPress(category : Category)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var categoryTypeLabel: UILabel!
  
    var delegate : CategoryCellDelegate?
    
    var category : TodoCategory! {
        didSet{
            categoryName.text = category.getName()
            idLabel.text = category.getID()
            
            switch category.getCategoryType() {
            case .IMAGES:
                categoryTypeLabel.text = "Images"
            case .POLL:
                categoryTypeLabel.text = "Poll"
            case .TODO:
                categoryTypeLabel.text = "ToDo"
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressCategoryCell))
        longPressGestureRecognizer.delegate = self
        self.addGestureRecognizer(longPressGestureRecognizer)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func onLongPressCategoryCell() {
        print("on long press ... ")
        self.delegate?.onLongPress(category)
    }
}
