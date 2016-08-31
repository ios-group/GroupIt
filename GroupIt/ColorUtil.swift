//
//  ColorUtil.swift
//  GroupIt
//
//  Created by Ankit Jasuja on 8/31/16.
//  Copyright © 2016 iOS Group 5. All rights reserved.
//

import UIKit

class ColorUtil: NSObject {
    
    static func getCellColor(index : Int) -> UIColor {
        let moduloIndex = index % 10
        return ColorTheme.CELL_COLORS[moduloIndex]
    }
    
}
