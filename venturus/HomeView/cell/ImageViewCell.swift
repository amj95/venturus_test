//
//  ImageViewCell.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation
import UIKit
import Kingfisher
import GoneVisible

class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbUp: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbView: UILabel!
    @IBOutlet weak var ivReload: UIImageView!
    var imageUrl: String = ""
    
    func prepare(up: String, comment: String, views: String, imageUrl: String?) {
        lbUp.text = up
        lbComment.text = comment
        lbView.text = views
        if let image = imageUrl {
            self.imageUrl = image
        }
        ivReload.image = UIImage(named: "sync")
    }
    
    func loadImage() {
        ivReload.animate()
        ivReload.visible()
        let url = URL(string: imageUrl)
        ivCover.kf.indicatorType = .activity
        ivCover.kf.setImage(
            with: url,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { result in
            switch result {
            case .success(let value):
                self.ivReload.gone()
                self.ivReload.removeAnimation()
            case .failure(let error):
                self.ivReload.visible()
                self.ivReload.removeAnimation()
                self.setRetry()
            }
        }
    }
    
    func setRetry() {
        ivReload.image = UIImage(named: "retry")
    }
    
}

extension UIView{
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
