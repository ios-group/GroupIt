//
//  ImageItemMapper.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/24/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ImageItemMapper: NSObject {

    func toImageItemDO(categoryDO : CategoryDO, imageItem : ImageItem) -> ImageItemDO {
        let imageItemDO = ImageItemDO()
        imageItemDO.objectId = imageItem.imageItemId
        imageItemDO["imageItemName"] = imageItem.imageItemName
        imageItemDO["imageItemDescription"] = imageItem.imageItemDescription
//        imageItemDO["image"] = imageItem.image
        return imageItemDO
    }
    
    func toImageItem(imageItemDO : ImageItemDO) -> ImageItem {
        var imageItemDictionary = Dictionary<String, AnyObject?>()
        imageItemDictionary["imageId"] = imageItemDO.objectId
        imageItemDictionary["imageItemName"] = imageItemDO["imageItemName"]
        imageItemDictionary["imageItemDescription"] = imageItemDO["imageItemDescription"]
        let todoItem = ImageItem(imageItemDictionary: imageItemDictionary)
        return todoItem
    }

}
