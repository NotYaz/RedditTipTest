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
    @IBOutlet weak var contentContainerBottomSpacing: NSLayoutConstraint!
    @IBOutlet var panGR: UIPanGestureRecognizer!

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

extension BaseSlidingVC {

    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
//        switch sender.state {
//        case .began, .changed:
//            if sender.state == .began {
//
//            } else {
//
//            }
//            let translation = sender.translation(in: view)
//            let newOffset = contentContainerTopSpacing.constant + translation.y
//            if topConstraintRange.contains(newOffset) {
//                contentContainerTopSpacing.constant = newOffset
//            }
//            sender.setTranslation(.zero, in: view)
//        case .ended:
//            let firstDistance = abs(topConstraintRange.upperBound - contentContainerTopSpacing.constant)
//            let secondDistance = abs(topConstraintRange.lowerBound - contentContainerTopSpacing.constant)
//
//            let velocity = sender.velocity(in: view).y
//            if abs(velocity) > 1000.0 {
//                if velocity < 0 { // UP
//                    contentContainerTopSpacing.constant = topConstraintRange.lowerBound
//                } else { // Down
//                    contentContainerTopSpacing.constant = topConstraintRange.upperBound
//                }
//            } else {
//                if secondDistance < firstDistance {
//                    contentContainerTopSpacing.constant = topConstraintRange.lowerBound
//                } else {
//                    contentContainerTopSpacing.constant = topConstraintRange.upperBound
//                }
//            }
//            UIView.animate(withDuration: 0.1, delay: 0.0, options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseOut], animations: {
//                self.view.layoutIfNeeded()
//            })
//        default:
//            break
//        }
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
