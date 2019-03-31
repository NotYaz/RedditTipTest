//
//  BaseSlidingVC.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

class BaseSlidingVC: BaseVC {
    
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var contentContainerTopSpacing: NSLayoutConstraint!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == dimView {
            dismiss()
        }
    }

}

extension BaseSlidingVC: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidingTransition(isPresenting: false)
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlidingTransition(isPresenting: true)
    }
    
}
