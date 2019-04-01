//
//  FeedVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

final class FeedVC: BaseVC {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var tipView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension FeedVC {

    private func setupUI() {
        tipView.isHidden = true
    }

    private func showTip(with amount: Int) {
        amountLabel.text = "\(amount).00"
        tipView.alpha = 0.0
        tipView.isHidden = false
        tipView.transform = CGAffineTransform(translationX: 0.0, y: 20.0).scaledBy(x: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, delay: 1.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            self.tipView.alpha = 1.0
            self.tipView.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 4.0, options: .curveEaseIn, animations: {
                self.tipView.alpha = 0.0
                self.tipView.transform = CGAffineTransform(translationX: 0.0, y: -20.0).scaledBy(x: 1.5, y: 1.5)
            }) { _ in
                self.tipView.isHidden = true
            }
        }
    }

}

extension FeedVC {

    @IBAction func tipButtonClicked(_ sender: Any) {
        perform(segue: StoryboardSegue.Feed.tipSlidingVC)
    }

}

extension FeedVC {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case StoryboardSegue.Feed.tipSlidingVC.rawValue:
            let tipVC = segue.destination as? TipSlidingVC
            tipVC?.successBlock = { amount in
                self.showTip(with: amount)
            }
        default:
            break
        }
    }

}
