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
    var id : String
    var imageName : String?
    var imageDescription : String?
    
    init(imageCategoryDictionary : Dictionary<String, AnyObject>) {
        id = imageCategoryDictionary["id"] as! String
        imageName = imageCategoryDictionary["imageName"] as? String
        imageDescription = imageCategoryDictionary["imageDescription"] as? String
    }
    
    var description: String {
        get {
            return self.imageName!
        }
    }

}
