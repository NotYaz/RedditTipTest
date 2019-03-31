//
//  BaseVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension BaseVC {

    func dismiss(completion: Block? = nil) {
        presentingViewController?.dismiss(animated: true, completion: completion)
    }

}
