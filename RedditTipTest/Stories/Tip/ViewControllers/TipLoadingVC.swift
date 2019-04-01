//
//  TipLoadingVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 01/04/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

final class TipLoadingVC: BaseVC {

    @IBOutlet weak var coinView: UIView!
    @IBOutlet weak var logoIM: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension TipLoadingVC {

    private func setupUI() {
        logoIM.isHidden = true
        coinView.alpha = 0.0
        coinView.transform = CGAffineTransform(translationX: 0.0, y: 50.0).scaledBy(x: 0.5, y: 0.5)
    }

    private func rotate(_ showLogo: Bool = true) {
        UIView.transition(with: coinView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
            self.amountLabel.isHidden = showLogo
            self.logoIM.isHidden = !showLogo
        }) { _ in
            guard self.parent != nil else {
                return
            }
            self.rotate(!showLogo)
        }
    }

}

extension TipLoadingVC {

    func startAnimation(with amount: Int) {
        amountLabel.text = "$\(amount)"
        UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseIn, animations: {
            self.coinView.alpha = 1.0
            self.coinView.transform = .identity
        }) { _ in
            self.rotate()
        }
    }

}
