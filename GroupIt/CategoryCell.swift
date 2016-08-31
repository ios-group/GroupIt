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
    @IBOutlet weak var categoryTypeLabel: UILabel!
  
    var delegate : CategoryCellDelegate?
    
    var category : Category?
    
//    var category : Category! {
//        didSet{
//            categoryName.text = category.categoryName
//            idLabel.text = category.categoryId
//            
//            switch category.categoryType {
//            case .IMAGES:
//                categoryTypeLabel.text = "Images"
//                break
//            case .POLL:
//                categoryTypeLabel.text = "Poll"
//                break
//            case .TODO:
//                categoryTypeLabel.text = "ToDo"
//                break
//            }
//            
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .DisclosureIndicator
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressCategoryCell))
        longPressGestureRecognizer.delegate = self
        self.addGestureRecognizer(longPressGestureRecognizer)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func onLongPressCategoryCell() {
        print("on long press ... ")
        self.delegate?.onLongPress(category!)
    }
}
