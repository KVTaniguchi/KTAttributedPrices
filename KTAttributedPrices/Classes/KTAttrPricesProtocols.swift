//
//  PricingProtocols.swift
//
//  Created by Kevin Taniguchi on 7/7/16.
//

import Foundation
import UIKit

typealias PriceRange = (lowPriceString: NSAttributedString?, highPriceString: NSAttributedString?)

protocol ListPriceable {
    func listFormattedPrice(listPrice: NSNumber, textColor: UIColor, isStrikeThrough: Bool) -> NSAttributedString?
}

protocol SalePriceable {
    func saleFormatedPrice(saleValue: NSNumber, color: UIColor) -> NSAttributedString?
    func isMarkDown(salePrice: NSNumber) -> Bool
}

protocol PromoPriceable {
    func promoFormattedText(promo: String) -> NSAttributedString?
}

protocol RangePriceable {
    func rangeFormattedPrices(priceRange: PriceRange, separatorColor: UIColor, isStrikeThrough: Bool) -> NSAttributedString?
}

protocol TotalPriceable {
    func totalFromQuantity(quantity: Int, pricePerUnit: NSNumber, color: UIColor) -> NSAttributedString?
}

protocol ConstructPriceable {
    func constructedPrices(prices: [NSAttributedString?]) -> NSAttributedString?
}
