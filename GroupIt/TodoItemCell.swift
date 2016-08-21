//
//  TodoItemCell.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/14/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

@objc protocol TodoItemCellDelegate {
    optional func onLongPress(todoItem : TodoItem)
    optional func onSwipeLeft(todoItem : TodoItem)
}

class TodoItemCell: UITableViewCell {

    @IBOutlet weak var todoItemNameLabel: UILabel!
    
    var todoItem : TodoItem?
    var delegate : TodoItemCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        todoItemNameLabel.text = todoItem?.todoItemName

        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressTodoItemCell))
        longPressGestureRecognizer.delegate = self
        self.addGestureRecognizer(longPressGestureRecognizer)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func onLongPressTodoItemCell() {
        print("on long press ... ")
        self.delegate?.onLongPress!(self.todoItem!)
    }    
}
