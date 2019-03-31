//
//  PaymentItem.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit
import DifferenceKit

struct PaymentItem {

    enum Category {
        case collapsedCard
        case card
        case add
    }

    var title: String
    var category: Category

}

extension PaymentItem: Equatable {

}

extension PaymentItem: Differentiable {

    var differenceIdentifier: String {
        return title
    }

    func isContentEqual(to source: PaymentItem) -> Bool {
        return self == source
    }

}
