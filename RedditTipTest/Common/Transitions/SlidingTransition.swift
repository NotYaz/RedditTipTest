//
//  SlidingTransition.swift
//  RedditTipTest
//
//  Created by Ivan Kozlov on 31/03/2019.
//  Copyright © 2019 Reddit. All rights reserved.
//

import UIKit

final class SlidingTransition: NSObject {
    
    private let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
}

extension SlidingTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? 0.7 : 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)!
        let fromVC = transitionContext.viewController(forKey: .from)!
        
        if isPresenting {
            let popupVC = toVC as! BaseSlidingVC
            popupVC.dimView.alpha = 0.0
            popupVC.contentContainer.alpha = 0.0
            popupVC.contentContainer.transform = CGAffineTransform(translationX: 0.0, y: UIScreen.main.bounds.size.height)
            
            transitionContext.containerView.addSubview(toVC.view)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext) / 2, animations: {
                popupVC.dimView.alpha = 0.8
            }, completion: { _ in
                UIView.animate(withDuration: self.transitionDuration(using: transitionContext) / 2,
                               delay: 0.0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0.0,
                               options: .curveLinear,
                               animations: {
                    popupVC.contentContainer.alpha = 1.0
                    popupVC.contentContainer.transform = .identity
                }, completion: { _ in
                    transitionContext.completeTransition(true)
                })
            })
        } else {
            let popupVC = fromVC as! BaseSlidingVC
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveLinear, animations: {
                popupVC.dimView.alpha = 0.0
                popupVC.contentContainer.alpha = 0.0
            })
            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0.0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.0,
                           options: .curveLinear,
                           animations: {
                popupVC.contentContainer.transform = CGAffineTransform(translationX: 0.0, y: popupVC.contentContainer.frame.size.height)
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
        }
    }
    
}

