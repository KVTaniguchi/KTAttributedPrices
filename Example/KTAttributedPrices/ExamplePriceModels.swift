//
//  ExamplePriceModels.swift
//  KTAttributedPrices
//
//  Created by Kevin Taniguchi on 7/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

struct SinglePrice {
    let listPrice: Double
    let salePrice: Double
    let promo: String?
}

struct RangedPrice {
    let listLow: Double
    let listHigh: Double
    let saleLow: Double
    let saleHigh: Double
    let promo: String?
}