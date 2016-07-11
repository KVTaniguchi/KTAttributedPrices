//
//  ExampleModelExtensions.swift
//  KTAttributedPrices
//
//  Created by Kevin Taniguchi on 7/11/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import KTAttributedPrices

extension SinglePrice: ListPriceable, SalePriceable, ConstructPriceable {
    func attributedPrice() -> NSAttributedString? {
        if isOnSale {
            let listPriceString = listFormattedPrice(listPrice, color: UIColor.lightGrayColor(), isStrikeThrough: true)
            let salePriceString = saleFormatedPrice(salePrice, color: UIColor.blueColor())
            return constructedPrices([salePriceString, listPriceString])
        }
        else {
            return listFormattedPrice(listPrice, color: UIColor.darkGrayColor(), isStrikeThrough: false)
        }
    }
    
    var isOnSale: Bool {
        return listPrice != salePrice
    }
}

extension RangedPrice: RangePriceable, ConstructPriceable {
    
}
