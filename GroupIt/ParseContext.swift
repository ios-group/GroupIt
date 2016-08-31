//
//  ParseContext.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/20/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ParseContext: NSObject {

    var className : String!
    var predicateFormat : String?
    var includeKeyParams : [String] = []

    var innerClassName : String?
    var innerPredicateFormat : String?
    var innerIncludeKeyParams : [String] = []
    
    var limit : Int?
    var skip : Int?

    init(className : String) {
        self.className = className
    }

}
