//
//  Pricingprotocols.swift
//
//  Created by Kevin Taniguchi on 7/7/16.
//

import Foundation
import UIKit

public typealias PriceRange = (lowPriceString: NSAttributedString?, highPriceString: NSAttributedString?)

public protocol ListPriceable {
    func listFormattedPrice(listPrice: NSNumber, textColor: UIColor, isStrikeThrough: Bool) -> NSAttributedString?
}

public protocol SalePriceable {
    func saleFormatedPrice(saleValue: NSNumber, color: UIColor) -> NSAttributedString?
    func isMarkDown(salePrice: NSNumber) -> Bool
}

public protocol PromoPriceable {
    func promoFormattedText(promo: String) -> NSAttributedString?
}

public protocol RangePriceable {
    func rangeFormattedPrices(priceRange: PriceRange, separatorColor: UIColor, isStrikeThrough: Bool) -> NSAttributedString?
}

public protocol TotalPriceable {
    func totalFromQuantity(quantity: Int, pricePerUnit: NSNumber, color: UIColor) -> NSAttributedString?
}

public protocol ConstructPriceable {
    func constructedPrices(prices: [NSAttributedString?]) -> NSAttributedString?
}
