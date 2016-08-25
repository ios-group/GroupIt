//
//  ImageItemManager.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/24/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit
import Parse

class ImageItemManager: NSObject {

    let todoCategoryDao = ParseDAO(className: Constants.TODO_CATEGORY_CLASSNAME)
    let imageItemDao = ParseDAO(className: Constants.IMAGE_ITEM_CLASSNAME)
    
    let imageItemMapper = ImageItemMapper()
    let todoCategoryMapper = TodoCategoryMapper()
    
    func upsertImageItem(categoryId : String, imageItem : ImageItem, completion : (Bool, ImageItem?, NSError?) -> ()) -> Void {
        todoCategoryDao.getById(categoryId) { (todoCategoryPfObject : PFObject?, error : NSError?) in
            if error == nil {
                let imageItemDO = self.imageItemMapper.toImageItemDO(todoCategoryPfObject as! CategoryDO, imageItem: imageItem)
                self.imageItemDao.upsert(imageItemDO) { (created : Bool, pfObject : PFObject?, error : NSError?) in
                    let imageItem = self.imageItemMapper.toImageItem(pfObject as! ImageItemDO)
                    completion(created, imageItem, error)
                }
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func deleteImageItemById(id : String, completion : (Bool, NSError?) -> Void)  {
        imageItemDao.deleteById(id) { (deleted : Bool, error : NSError?) in
            completion(deleted, error)
        }
    }
    
    func getAllImageItems(completion : ([ImageItem], NSError?) -> Void) {
        var imageItems : [ImageItem] = []
        imageItemDao.getAll { (imageItemPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let imageItemPfObjects = imageItemPfObjects {
                    for imageItemPfObject in imageItemPfObjects {
                        imageItems.append(self.imageItemMapper.toImageItem(imageItemPfObject as! ImageItemDO))
                    }
                }
            }
            completion(imageItems, error)
        }
    }
    
//    func getAllImageItemsByCategoryId(categoryId : String, completion : ([ImageItem], NSError?) -> Void) {
//        var imageItems : [ImageItem] = []
//        let parseContext = ParseContext(className: Constants.IMAGE_ITEM_CLASSNAME)
//        parseContext.className = Constants.IMAGE_ITEM_CLASSNAME
//        parseContext.predicateFormat = "category IN %@"
//        parseContext.innerClassName = Constants.TODO_CATEGORY_CLASSNAME
//        parseContext.innerPredicateFormat = "objectId = '\(categoryId)'"
//        imageItemDao.getAllByForeignKey(parseContext) { (imageItemPfObjects : [PFObject]?, error : NSError?) in
//            if error == nil {
//                if let imageItemPfObjects = imageItemPfObjects {
//                    for imageItemPfObject in imageItemPfObjects {
//                        let imagePfFile = imageItemPfObject["image"] as? PFFile
//                        self.toUIImage(imagePfFile, completion: { (image : UIImage?) in
//                            if image != nil {
//                                imageItemPfObject["image2"] = image                                
//                            }
//                            imageItems.append(self.imageItemMapper.toImageItem(imageItemPfObject as! ImageItemDO))
//                        })
////                        imageItems.append(self.imageItemMapper.toImageItem(imageItemPfObject as! ImageItemDO))
//                    }
//                }
//            }
//            completion(imageItems, error)
//        }
//    }
    
    func getAllImageItemsByCategoryId(categoryId : String, completion : ([ImageItem], NSError?) -> Void) {
        var imageItems : [ImageItem] = []
        let parseContext = ParseContext(className: Constants.IMAGE_ITEM_CLASSNAME)
        parseContext.className = Constants.IMAGE_ITEM_CLASSNAME
        parseContext.predicateFormat = "category IN %@"
        parseContext.innerClassName = Constants.TODO_CATEGORY_CLASSNAME
        parseContext.innerPredicateFormat = "objectId = '\(categoryId)'"
        imageItemDao.getAllByForeignKey(parseContext) { (imageItemPfObjects : [PFObject]?, error : NSError?) in
            if error == nil {
                if let imageItemPfObjects = imageItemPfObjects {
                    for imageItemPfObject in imageItemPfObjects {
                        imageItems.append(self.imageItemMapper.toImageItem(imageItemPfObject as! ImageItemDO))
                    }
                }
            }
            completion(imageItems, error)
        }
    }

    func toUIImage(pfFile : PFFile?, completion : (UIImage?) -> ()) {
        if let pfFile = pfFile {
            pfFile.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        completion(UIImage(data:imageData))
                    }
                }
            }
        }
        completion(nil)
    }

    func toUIImage(pfFile : PFFile?) -> UIImage? {
        if let pfFile = pfFile {
            let fileData = try! pfFile.getData()
            return UIImage(data: fileData)
        }
        return nil
    }

}
