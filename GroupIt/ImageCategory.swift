//
//  ImageCategory.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ImageCategory: Category {

    /* imageName, imageDescription  */
//    var id : String?
//    var imageCategoryName : String?
//    var imageCategoryDescription : String?
    var imageItems : [ImageItem]?
    
    init() {
        super.init(categoryType: .IMAGES)
    }

    init(imageCategoryDictionary : Dictionary<String, AnyObject>) {
        super.init(categoryDictionary: imageCategoryDictionary)
//        id = imageCategoryDictionary["id"] as? String
//        imageCategoryName = imageCategoryDictionary["imageCategoryName"] as? String
//        imageCategoryDescription = imageCategoryDictionary["imageCategoryDescription"] as? String
    }
    
    override var description: String {
        get {
            return "\(super.description), \(self.imageItems)"
        }
    }
    
//    func getCategoryType() -> CategoryType {
//        return CategoryType.IMAGES
//    }
//    
//    func getID() -> String? {
//        return id
//    }
//    
//    func getName() -> String? {
//        return imageCategoryName
//    }

}


class ImageItem : NSObject {

    var imageItemId : String?
    var imageItemName : String?
    var imageItemDescription : String?
    var image : UIImage?
    
    init(imageItemDictionary : Dictionary<String, AnyObject?>) {
        imageItemId = imageItemDictionary["imageItemId"] as? String
        imageItemName = imageItemDictionary["imageItemName"] as? String
        imageItemDescription = imageItemDictionary["imageItemDescription"] as? String
    }
    
    override var description: String {
        get {
            return "\(self.imageItemId!), \(self.imageItemName), \(self.imageItemDescription)"
        }
    }

}