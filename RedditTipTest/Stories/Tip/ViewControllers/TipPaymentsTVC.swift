//
//  TipPaymentsTVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit
import DifferenceKit

protocol PaymentsDelegate: class {

    func paymentsDidExpand(_ paymentsTVC: TipPaymentsTVC)
    func paymentsDidCollapse(_ paymentsTVC: TipPaymentsTVC)

}

final class TipPaymentsTVC: BaseTVC {

    private var items: [PaymentItem] = []
    private var itemsProxy: [PaymentItem] = [] {
        didSet {
            let changeset = StagedChangeset(source: oldValue, target: itemsProxy)
            tableView.reload(using: changeset, with: .fade) { data in
                self.items = data
            }
        }
    }

    private var selectedCard: Card?
    private var isExpanded = false
    static let itemHeight: CGFloat = 48.0
    var height: CGFloat {
        return TipPaymentsTVC.itemHeight * CGFloat(items.count)
    }

    weak var delegate: PaymentsDelegate?

    // MARK: fake logic
    private let allCards = [Card(lastFourDigits: "0741", category: .visa),
                    Card(lastFourDigits: "3088", category: .mastercard),
                    Card(lastFourDigits: "2314", category: .amex)]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        selectedCard = allCards[0]
        itemsProxy = [PaymentItem(title: allCards[0].printableValue, category: .collapsedCard)]
    }

}

extension TipPaymentsTVC {

    private func reloadItems() {
        var newItems = allCards.map { PaymentItem(title: $0.printableValue, category: .card) }
        newItems.append(PaymentItem(title: "Add New Card", category: .add))
        itemsProxy = newItems
    }

}

extension TipPaymentsTVC {

    private func expand() {
        reloadItems()
        delegate?.paymentsDidExpand(self)
    }

    private func collapse() {
        guard let selectedCard = selectedCard else {
            return
        }
        itemsProxy = [PaymentItem(title: selectedCard.printableValue, category: .collapsedCard)]
        delegate?.paymentsDidCollapse(self)
    }

}

extension TipPaymentsTVC {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withClass: PaymentCell.self, for: indexPath)
        let item = items[indexPath.row]
        cell.item = item
        // MARK: Wrong way, just tmp logic :( Comparison by uniq card id will be more relieble
        cell.isChecked = isExpanded && item.title == selectedCard?.printableValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        guard item.category != .add else {
            // MARK: Add new payment method flow starts here. Nothing to do :)
            return
        }
        if isExpanded {
            // MARK: Bad comparison... again :(
            if item.title != selectedCard?.printableValue {
                selectedCard = allCards[indexPath.row]
            }
            isExpanded = false
            collapse()
        } else {
            isExpanded = true
            expand()
        }
    }

}
