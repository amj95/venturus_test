//
//  ImageViewCell.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation
import UIKit
import Kingfisher

class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbUp: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbView: UILabel!
    var imageUrl: String = ""
    
    func prepare(up: String, comment: String, views: String, imageUrl: String?) {
        lbUp.text = up
        lbComment.text = comment
        lbView.text = views
        if let image = imageUrl {
            self.imageUrl = image
        }
        ivCover.image = UIImage(named: "reload")
    }
    
    func loadImage() {
        if (imageUrl == "") {
            ivCover.image = UIImage(named: "reload")
        } else {
            if let url = URL(string: imageUrl) {
                ivCover.kf.indicatorType = .activity
                ivCover.kf.setImage(with: url , placeholder: UIImage(named: "cooperativa_default"))
            }
        }
    }
    
}
