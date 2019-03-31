//
//  Card.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 01/04/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

struct Card {

    enum Category: String {
        case visa = "VISA"
        case mastercard = "Mastercard"
        case amex = "AMEX"
    }

    var lastFourDigits: String
    var category: Category

    var printableValue: String {
        return "\(category.rawValue) •••• \(lastFourDigits)"
    }

}

extension Card: Equatable {

}
