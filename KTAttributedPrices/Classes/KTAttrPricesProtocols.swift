//
//  PricingProtocols.swift
//
//  Created by Kevin Taniguchi on 7/7/16.
//

import Foundation
import UIKit

typealias PriceRange = (lowPriceString: NSAttributedString?, highPriceString: NSAttributedString?)
typealias FormattedPrices = (list: NSAttributedString?, sale: NSAttributedString?, promo: NSAttributedString?)

private let currencyNumberFormatter = NSNumberFormatter()

protocol ListPriceable {
    func listFormattedPrice(listPrice: NSNumber, textColor: UIColor?, isStrikeThrough: Bool) -> NSAttributedString?
}

protocol SalePriceable {
    func saleFormatedPrice(saleValue: NSNumber, color: UIColor?) -> NSAttributedString?
    func isMarkDown(salePrice: NSNumber) -> Bool
}

protocol PromoPriceable {
    func promoFormattedText(promo: String?) -> NSAttributedString?
}

protocol RangePriceable {
    func rangeFormattedPrices(priceRange: PriceRange, separatorColor: UIColor, isStrikeThrough: Bool) -> NSAttributedString?
}

protocol TotalPriceable {
    func totalFromQuantity(quantity: Int, pricePerUnit: NSNumber, color: UIColor?) -> NSAttributedString?
}

protocol ConstructPriceable {
    func constructedPriceFromListPrice(prices: FormattedPrices, isMarkDown: Bool) -> NSAttributedString?
}

// Protocol Extensions
extension ListPriceable {
    func listFormattedPrice(listPrice: NSNumber, color: UIColor, isStrikeThrough: Bool) -> NSAttributedString? {
        guard let currencyList = currencyNumberFormatter.stringFromNumber(listPrice) else { return nil }
        let attr = isStrikeThrough ? [NSForegroundColorAttributeName: color, NSStrikethroughStyleAttributeName: 1] : [NSForegroundColorAttributeName: color]
        return NSAttributedString(string: currencyList, attributes: attr)
    }
}

extension SalePriceable {
    func saleFormatedPrice(saleValue: NSNumber, color: UIColor) -> NSAttributedString? {
        guard let currencySale = currencyNumberFormatter.stringFromNumber(saleValue) else { return nil }
        let saleColor = isMarkDown(saleValue) ? UIColor.redColor() : color
        return NSAttributedString(string: currencySale, attributes: [NSForegroundColorAttributeName: saleColor])
    }
}

extension PromoPriceable {
    func promoFormattedText(promo: String?) -> NSAttributedString? {
        guard let promo = promo else { return nil }
        return NSAttributedString(string: promo, attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
    }
}

extension RangePriceable {
    func rangeFormattedPrices(priceRange: PriceRange, separatorColor: UIColor, isStrikeThrough: Bool) -> NSAttributedString? {
        guard let rangedPriceString = [priceRange.lowPriceString, priceRange.highPriceString].joinWithSeparator(NSAttributedString(string: "-", attributes: [NSForegroundColorAttributeName: separatorColor])) else { return nil }
        guard !isStrikeThrough else {
            let strikableString = NSMutableAttributedString(attributedString: rangedPriceString)
            strikableString.addAttributes(listPriceStrikeThoughAttr, range: NSRange(location: 0, length: strikableString.length))
            return strikableString
        }
        return rangedPriceString
    }
}

extension TotalPriceable {
    // TODO for cost summaries in Basket Summary Footer, Basket Item cellsils
}

extension ConstructPriceable {
    func constructedPriceFromListPrice(prices: FormattedPrices, isMarkDown: Bool) -> NSAttributedString? {
        guard isMarkDown else {
            return [prices.list, prices.sale, prices.promo].joinedConstructPriceablePrices
        }
        
        return [prices.sale, prices.list, prices.promo].joinedConstructPriceablePrices
    }
}

// MARK Internal methods
private let attributedSpaceSeparator = NSAttributedString(string: " ")
private let listPriceStrikeThoughAttr = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSStrikethroughStyleAttributeName: 1]

extension _ArrayType where Generator.Element == NSAttributedString? {
    private func joinWithSeparator(separator: NSAttributedString) -> NSAttributedString? {
        let unwrappedStrings = flatMap{$0} as [NSAttributedString]
        
        var isFirst = true
        return unwrappedStrings.reduce(NSMutableAttributedString(), combine: { (string, element) in
            if isFirst {
                isFirst = false
            }
            else {
                string.appendAttributedString(separator)
            }
            string.appendAttributedString(element)
            return string
        })
    }
    
    var joinedConstructPriceablePrices: NSAttributedString? {
        return joinWithSeparator(attributedSpaceSeparator)
    }
}

