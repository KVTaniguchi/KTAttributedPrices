//
//  KTAttrPriceProtocolExtensions.swift
//  Pods
//
//  Created by Kevin Taniguchi on 7/7/16.
//
//

import Foundation

private let currencyNumberFormatter = NSNumberFormatter()


// Protocol Extensions that assist in generating the attributed strings
extension AttributedPrices {
    func listFormattedPrice(listPrice: NSNumber, color: UIColor, isStrikeThrough: Bool) -> NSAttributedString? {
        guard let currencyList = currencyNumberFormatter.stringFromNumber(listPrice) else { return nil }
        
        let listAttr = isStrikeThrough ? strikethroughAttr(color) : [NSForegroundColorAttributeName: color]
        return NSAttributedString(string: currencyList, attributes: listAttr)
    }
    
    func constructedPrice(list list: NSAttributedString?, sale: NSAttributedString?, promo: NSAttributedString? = nil, isMarkDown: Bool) -> NSAttributedString? {
        return isMarkDown ? [sale, list, promo].joinAttributedPrices : [list, sale, promo].joinAttributedPrices
    }
}

extension AttributedSale {
    func saleFormatedPrice(saleValue: NSNumber, color: UIColor) -> NSAttributedString? {
        guard let currencySale = currencyNumberFormatter.stringFromNumber(saleValue) else { return nil }
        
        let salePriceAttr = [NSForegroundColorAttributeName: color]
        return NSAttributedString(string: currencySale, attributes: salePriceAttr)
    }
    
    func isMarkDown(salePrice: NSNumber) -> Bool {
        return salePrice.floatValue % 10 != 0
    }
}

extension AttributedProductPromotion {
    func promoFormattedText(promo: String?, color: UIColor) -> NSAttributedString? {
        guard let promo = promo else { return nil }
        return NSAttributedString(string: promo, attributes: [NSForegroundColorAttributeName: color])
    }
}

extension AttributedRangePrice {
    func rangeFormattedPrices(priceRange: PriceRange, color: UIColor, isStrikeThrough: Bool) -> NSAttributedString? {
        guard let rangedPriceString = [priceRange.lowPriceString, priceRange.highPriceString].join(withSeparator: NSAttributedString(string: "-", attributes: [NSForegroundColorAttributeName: color])) else { return nil }
        guard !isStrikeThrough else {
            let strikableString = NSMutableAttributedString(attributedString: rangedPriceString)
            strikableString.addAttributes(strikethroughAttr(strikeThroughColor), range: NSRange(location: 0, length: strikableString.length))
            return strikableString
        }
        return rangedPriceString
    }
}

// MARK Internal methods
private let attributedSpaceSeparator = NSAttributedString(string: " ")

private func strikethroughAttr(color: UIColor) -> [String: AnyObject] {
    return [NSForegroundColorAttributeName: color, NSStrikethroughStyleAttributeName: 1]
}

extension _ArrayType where Generator.Element == NSAttributedString? {
    private func join(withSeparator separator: NSAttributedString) -> NSAttributedString? {
        let unwrappedStrings = flatMap{$0} as [NSAttributedString]
        
        var shouldAddSeparator = false
        return unwrappedStrings.reduce(NSMutableAttributedString(), combine: { (string, element) in
            if shouldAddSeparator {
                string.appendAttributedString(separator)
            }
            else {
                shouldAddSeparator = true
            }
            string.appendAttributedString(element)
            return string
        })
    }
    
    var joinAttributedPrices: NSAttributedString? {
        return join(withSeparator: attributedSpaceSeparator)
    }
}
