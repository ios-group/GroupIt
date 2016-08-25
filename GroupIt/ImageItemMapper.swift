//
//  ImageItemMapper.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/24/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class ImageItemMapper: NSObject {

    func toImageItemDO(categoryDO : CategoryDO, imageItem : ImageItem) -> ImageItemDO {
        let imageItemDO = ImageItemDO()
        imageItemDO.objectId = imageItem.imageItemId
        imageItemDO["imageItemName"] = imageItem.imageItemName
//        imageItemDO["imageItemDescription"] = imageItem.imageItemDescription
        imageItemDO["image"] = toPfFile(imageItem.image)
        imageItemDO["category"] = categoryDO
        return imageItemDO
    }
    
    func toImageItem(imageItemDO : ImageItemDO) -> ImageItem {
        var imageItemDictionary = Dictionary<String, AnyObject?>()
        imageItemDictionary["imageId"] = imageItemDO.objectId
        imageItemDictionary["imageItemName"] = imageItemDO["imageItemName"]
        imageItemDictionary["image"] = toUIImage(imageItemDO["image"] as? PFFile)
//        imageItemDictionary["imageItemDescription"] = imageItemDO["imageItemDescription"]
        let imageItem = ImageItem(imageItemDictionary: imageItemDictionary)
        return imageItem
    }

    func toPfFile(image : UIImage?) -> PFFile? {
//        let imageData = UIImagePNGRepresentation(image!)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        let imageFile = PFFile(name:"image.png", data: imageData!)
        return imageFile
    }
    
    func toUIImage(pfFile : PFFile?) -> UIImage? {
        if let pfFile = pfFile {
            let fileData = try! pfFile.getData()
            return UIImage(data: fileData)
        }
        return nil
    }

//    func toUIImage(pfFile : PFFile?) -> UIImage? {
//        if let pfFile = pfFile {
//            pfFile.getDataInBackgroundWithBlock {
//                (imageData: NSData?, error: NSError?) -> Void in
//                if error == nil {
//                    if let imageData = imageData {
//                        return UIImage(data:imageData)
//                    }
//                }
//            }
//        }
//        return nil
//    }
}
