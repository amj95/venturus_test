//
//  ImageViewCell.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation
import UIKit

class ImageViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivCover: UIImageView!
    @IBOutlet weak var lbUp: UILabel!
    @IBOutlet weak var lbComment: UILabel!
    @IBOutlet weak var lbView: UILabel!
    
    func prepare(up: String, comment: String, views: String) {
        lbUp.text = up
        lbComment.text = comment
        lbView.text = views
        ivCover.image = UIImage(named: "reload")
    }
    
    func loadImage() {
        print("show request")
    }
}
