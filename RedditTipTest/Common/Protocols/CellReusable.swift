//
//  CellReusable.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

protocol CellReusable {

    func dequeueCell<T>(withClass class: T.Type, for indexPath: IndexPath) -> T

    func registerCell<T>(withClass class: T.Type)
}

extension CellReusable where Self: UITableView {

    func registerCell<T>(withClass class: T.Type) {
        let cellClassName = String(describing: T.self)
        register(UINib(nibName: cellClassName, bundle: nil), forCellReuseIdentifier: cellClassName)
    }

    func dequeueCell<T>(withClass class: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    func dequeueCell<T>(withClass class: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
}
