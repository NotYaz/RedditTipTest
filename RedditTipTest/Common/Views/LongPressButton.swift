//
//  LongPressButton.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 01/04/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

final class LongPressButton: UIButton {

    private var longPressGR: UILongPressGestureRecognizer?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGR()
    }

}

extension LongPressButton {

    private func setupGR() {
        longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(longGRFired))
        longPressGR?.minimumPressDuration = 1.0
        longPressGR?.cancelsTouchesInView = true
        addGestureRecognizer(longPressGR!)
    }

    @objc private func longGRFired() {
        sendActions(for: .touchUpInside)
    }

}
