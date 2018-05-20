//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Permi on 2018/5/20.
//  Copyright © 2018 Permi. All rights reserved.
//

import UIKit

class DimmingPresentationController : UIPresentationController {
    
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView!.insertSubview(dimmingView, at: 0)
        
        dimmingView.alpha = 0
        if let coordinator =
            presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
            }, completion: nil)
        }
        
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator =
            presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            }, completion: nil)
        }
    }
}
