//
//  TipSlidingVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit
import TTTAttributedLabel

final class TipSlidingVC: BaseSlidingVC {

    @IBOutlet weak var amountButton: UIButton!
    @IBOutlet weak var tipButton: UIButton!
    @IBOutlet weak var avatarIM: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var paymentsHeight: NSLayoutConstraint!
    @IBOutlet weak var tosLabel: TTTAttributedLabel!

    let baseHeight: CGFloat = 298.0
    let animationDuration = 0.3
    let amountRange = (1...100)

    var isExpanded = false {
        didSet {
            paymentsHeight.constant = isExpanded ?  paymentsTVC.height : TipPaymentsTVC.itemHeight
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    var currentAmount = 1 {
        didSet {
            amountButton.setTitle("$\(currentAmount)", for: .normal)
        }
    }
    weak var paymentsTVC: TipPaymentsTVC!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        tosLabel.linkAttributes = [NSAttributedString.Key.foregroundColor: Resources.Colors.deepBlue.color,
                                   NSAttributedString.Key.underlineStyle: 0]
        if let tosText = tosLabel.text as? String, let range = tosText.range(of: "Beta Terms of Service") {
            tosLabel.addLink(to: URL(string: "/zero"), with: NSRange(range, in: tosText))
        }
    }

}

extension TipSlidingVC {

    private func setupUI() {
        currentAmount = 1
    }

}

extension TipSlidingVC {

    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss()
    }

    @IBAction func minusButtonClicked(_ sender: Any) {
        if amountRange ~= currentAmount - 1 {
            currentAmount -= 1
        }
    }

    @IBAction func plusButtonClicked(_ sender: Any) {
        if amountRange ~= currentAmount + 1 {
            currentAmount += 1
        }
    }

    @IBAction func tipButtonClicked(_ sender: Any) {

    }

}

extension TipSlidingVC {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case StoryboardSegue.Tip.tipPaymentsTVC.rawValue:
            paymentsTVC = segue.destination as? TipPaymentsTVC
            paymentsTVC.delegate = self
        default:
            break
        }
    }

}

extension TipSlidingVC: PaymentsDelegate {

    func paymentsDidExpand(_ paymentsTVC: TipPaymentsTVC) {
        isExpanded = true
    }

    func paymentsDidCollapse(_ paymentsTVC: TipPaymentsTVC) {
        isExpanded = false
    }

}
