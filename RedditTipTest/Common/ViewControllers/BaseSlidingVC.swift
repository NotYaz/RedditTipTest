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

    var initialBottomSpacing: CGFloat = 0.0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        modalPresentationStyle = .custom
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialBottomSpacing = contentContainerBottomSpacing.constant
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == dimView {
            dismiss()
        }
    }

}

extension BaseSlidingVC {

    @IBAction func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let translation = sender.translation(in: view)
            let newOffset = contentContainerBottomSpacing.constant - translation.y
            if newOffset <= initialBottomSpacing {
                contentContainerBottomSpacing.constant = newOffset
            }
            sender.setTranslation(.zero, in: view)
        case .ended:
            if contentContainerBottomSpacing.constant > 0.0 {
                contentContainerBottomSpacing.constant = initialBottomSpacing
                UIView.animate(withDuration: 0.1,
                               delay: 0.0,
                               options: [.beginFromCurrentState, .allowUserInteraction, .curveEaseOut], animations: {
                    self.view.layoutIfNeeded()
                })
            } else {
                dismiss()
            }
        default:
            break
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
