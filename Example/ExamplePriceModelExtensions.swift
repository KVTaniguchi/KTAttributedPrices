//
//  ExamplePriceModelExtensions.swift
//  KTAttributedPrices
//
//  Created by Kevin Taniguchi on 7/24/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import KTAttributedPrices

extension SinglePrice: AttributedPrices {
    var strikeThroughColor: UIColor {
        return UIColor.lightGrayColor()
    }
    
    var salePriceColor: UIColor {
        return UIColor.redColor()
    }
    
    
}