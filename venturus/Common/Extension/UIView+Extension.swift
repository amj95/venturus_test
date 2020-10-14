//
//  UIView+Extension.swift
//  venturus
//
//  Created by antonio marcos on 14/10/20.
//

import Foundation
import UIKit

extension UIView {
    func animate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1.5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func removeAnimation() {
       self.layer.removeAllAnimations()
       self.layoutIfNeeded()
   }
}
