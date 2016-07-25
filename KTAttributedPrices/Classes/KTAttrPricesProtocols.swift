//
//  Pricingprotocols.swift
//
//  Created by Kevin Taniguchi on 7/7/16.
//

import Foundation
import UIKit

typealias PriceRange = (lowPriceString: NSAttributedString?, highPriceString: NSAttributedString?)

private let currencyNumberFormatter = NSNumberFormatter()

public protocol AttributedPrices {
    var strikeThroughColor: UIColor { get }
    var salePriceColor: UIColor { get }
}

public protocol AttributedPricesForSummarySheet: AttributedPrices {
    func attributedPrice(price: NSNumber) -> NSAttributedString?
}

public protocol AttributedPricesWithPromos: AttributedPrices {
    func attributedPriceString(withPromo promo: NSAttributedString?) -> NSAttributedString?
}

public protocol AttributedSale: AttributedPrices {
    var isSale: Bool { get }
    var isMarkDown: Bool { get }
}

public protocol AttributedProductPromotion {
    var promoString: NSAttributedString? { get }
}

public protocol AttributedRangePrice: AttributedPrices {
    var rangedListString: NSAttributedString? { get }
    var rangedSaleString: NSAttributedString? { get }
    var hasPriceRange: Bool { get }
}
