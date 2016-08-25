//
//  ImageCell.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/23/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageItemNameLabel: UILabel!
    
    var imageItem : ImageItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageItemNameLabel.text = imageItem?.imageItemName
//        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(onLongPressTodoItemCell))
//        longPressGestureRecognizer.delegate = self
//        self.addGestureRecognizer(longPressGestureRecognizer)
    }

}
