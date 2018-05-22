//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by Permi on 2018/5/22.
//  Copyright © 2018年 Permi. All rights reserved.
//

import UIKit

class FadeOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromView = transitionContext.view(forKey: .from) {
            let time = transitionDuration(using: transitionContext)
            UIView.animate(withDuration: time, animations: {
                fromView.alpha = 0
            }) { (finished) in
                transitionContext.completeTransition(finished)
            }
        }
    }
}
