//
//  KTAttrPriceProtocolExtensions.swift
//  Pods
//
//  Created by Kevin Taniguchi on 7/7/16.
//
//

import Foundation

private let currencyNumberFormatter = NSNumberFormatter()

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
    func promoFormattedText(promo: String) -> NSAttributedString {
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
    func totalFromQuantity(quantity: Int, pricePerUnit: NSNumber, color: UIColor) -> NSAttributedString? {
        let totalPrice = Double(quantity) * Double(pricePerUnit)
        guard let totalString = currencyNumberFormatter.stringFromNumber(totalPrice) else { return nil }
        return NSAttributedString(string: totalString, attributes: [NSForegroundColorAttributeName: color])
    }
}

extension ConstructPriceable {
    func constructedPriceFromListPrice(prices: [NSAttributedString?]) -> NSAttributedString? {
        return prices.joinedConstructPriceablePrices
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
