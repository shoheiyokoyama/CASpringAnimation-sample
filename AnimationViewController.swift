//
//  AnimationViewController.swift
//  iOS-9-Sampler
//
//  Created by Shohei Yokoyama on 2015/10/05.
//  Copyright © 2015年 Shohei. All rights reserved.
//
// Tanks to
// https://github.com/shu223/iOS-9-Sampler

import UIKit

class AnimationViewController: UIViewController {
    
    var animationView: SpringAnimationView
    let animation = CASpringAnimation(keyPath: "position")
    
    init() {
        animationView = SpringAnimationView()
        super.init(nibName: nil, bundle: nil)
        
        animationView.frame = self.view.bounds
        view.addSubview(animationView)
        
        self.animationViewAction()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        animation.initialVelocity = -5.0
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let fromPostion = CGPoint(x: CGRectGetMidX(view.bounds) + 100, y: animationView.dogImage.center.y)
        let toPosition   = CGPoint(x: fromPostion.x - 200, y: fromPostion.y)
        animation.fromValue = NSValue(CGPoint: fromPostion)
        animation.toValue = NSValue(CGPoint: toPosition)
        
        animationView.dogImage.center = fromPostion
    }
    
    func animationViewAction() {
        animationView.tappedButton = { () -> Void in
            self.animationView.animationButton.enabled = false
            self.animation.duration = self.animation.settlingDuration
            self.animationView.dogImage.layer.addAnimation(self.animation, forKey: nil)
        }
        
        animationView.updateMassValue = { (value: Float) -> Void in
            self.animation.mass = CGFloat(value)
        }
        
        animationView.updateStiffnessValue = { (value: Float) -> Void in
            self.animation.stiffness = CGFloat(value)
        }
        
        animationView.updateDampingValue = { (value: Float) -> Void in
            self.animation.damping = CGFloat(value)
        }
    }
    
    // MARK: - CAAnimationDelegate
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        animationView.animationButton.enabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
