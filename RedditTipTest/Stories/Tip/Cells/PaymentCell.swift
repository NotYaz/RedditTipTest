//
//  PaymentCell.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

final class PaymentCell: UITableViewCell {

    @IBOutlet weak var shapeIM: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkIM: UIImageView!

    var item: PaymentItem? {
        didSet {
            guard let item = item else {
                return
            }
            titleLabel.text = item.title
            switch item.category {
            case .collapsedCard:
                shapeIM.image = Resources.Assets.grayLockShape.image
                titleLabel.textColor = Resources.Colors.deepBlue.color
            case .card:
                shapeIM.image = Resources.Assets.blackLockShape.image
                titleLabel.textColor = Resources.Colors.deepBlack.color
            case .add:
                shapeIM.image = Resources.Assets.addShape.image
                titleLabel.textColor = Resources.Colors.deepBlack.color
            }
        }
    }

    var isChecked = false {
        didSet {
            checkIM.isHidden = !isChecked
        }
    }

}
