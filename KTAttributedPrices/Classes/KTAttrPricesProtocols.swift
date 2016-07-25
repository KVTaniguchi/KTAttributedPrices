//
//  Pricingprotocols.swift
//
//  Created by Kevin Taniguchi on 7/7/16.
//

import Foundation
import UIKit

typealias PriceRange = (lowPriceString: NSAttributedString?, highPriceString: NSAttributedString?)

private let currencyNumberFormatter = NSNumberFormatter()

protocol AttributedPrices {
    var strikeThroughColor: UIColor { get }
}

protocol AttributedPricesForSummarySheet: AttributedPrices {
    func attributedPrice(price: NSNumber) -> NSAttributedString?
}

protocol AttributedPricesWithPromos: AttributedPrices {
    func attributedPriceString(withPromo promo: NSAttributedString?) -> NSAttributedString?
}

protocol AttributedSale: AttributedPrices {
    var isSale: Bool { get }
    var isMarkDown: Bool { get }
}

protocol AttributedProductPromotion {
    var promoString: NSAttributedString? { get }
}

protocol AttributedRangePrice: AttributedPrices {
    var rangedListString: NSAttributedString? { get }
    var rangedSaleString: NSAttributedString? { get }
    var hasPriceRange: Bool { get }
}
