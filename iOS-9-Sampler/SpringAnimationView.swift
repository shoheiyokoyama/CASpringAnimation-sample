//
//  SpringAnimationView.swift
//  iOS-9-Sampler
//
//  Created by Shohei Yokoyama on 2015/10/05.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

class SpringAnimationView: UIView {

    @IBOutlet weak var massValueLabel: UILabel!
    @IBOutlet weak var stiffnessValueLabel: UILabel!
    @IBOutlet weak var dampingValueLabel: UILabel!
    @IBOutlet weak var massSlider: UISlider!
    @IBOutlet weak var stiffnessSlider: UISlider!
    @IBOutlet weak var dampingSlider: UISlider!
    @IBOutlet weak var animationButton: UIButton!
    
    @IBOutlet weak var dogImage: UIImageView!
    
    var tappedButton:(() -> ())?
    
    var updateMassValue:((Float) -> ())?
    var updateStiffnessValue:((Float) -> ())?
    var updateDampingValue:((Float) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadXibFile()
        self.setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadXibFile() {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "SpringAnimationView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil).first as! UIView
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|",
            options:NSLayoutFormatOptions(rawValue: 0),
            metrics:nil,
            views: bindings))
    }

    @IBAction func onClickButton(sender: AnyObject) {
        self.tappedButton!()
    }
    
    func setup() {
        massSlider.value = 0
        massSlider.addTarget(self, action: "massSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        massValueLabel.text = "\(massSlider.value)"
        
        stiffnessSlider.value = 0
        stiffnessSlider.addTarget(self, action: "stiffnessSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        stiffnessValueLabel.text = "\(stiffnessSlider.value)"
        
        dampingSlider.value = 0
        dampingSlider.addTarget(self, action: "dampingSliderValueChange:", forControlEvents: UIControlEvents.ValueChanged)
        dampingValueLabel.text = "\(dampingSlider.value)"
    }
    
    internal func massSliderValueChange(sender : UISlider) {
        massValueLabel.text = "\(sender.value)"
        self.updateMassValue!(sender.value)
    }
    
    internal func stiffnessSliderValueChange(sender : UISlider) {
        stiffnessValueLabel.text = "\(sender.value)"
        self.updateStiffnessValue!(sender.value)
    }
    
    internal func dampingSliderValueChange(sender : UISlider) {
        dampingValueLabel.text = "\(sender.value)"
        self.updateDampingValue!(sender.value)
    }
    
}
