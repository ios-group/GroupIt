//
//  Category.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/11/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

protocol Category: CustomStringConvertible {

    /**
     * categoryId, categoryType enum, categoryOwner
     */
}

enum CategoryType {
    case TODO
    case POLL
    case IMAGES
}
