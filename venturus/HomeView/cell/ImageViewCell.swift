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
    
    var viewModel: ImageCellViewModel?
    var imageUrl: String = ""
    
    func prepare(viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        lbUp.text = viewModel.up
        lbComment.text = viewModel.comment
        lbView.text = viewModel.views
        if let image = viewModel.imageUrl {
            self.imageUrl = image
        }
        
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(loadImage))
        ivReload.addGestureRecognizer(tapRec)
        ivReload.isUserInteractionEnabled = true;
    }
    
    @objc func loadImage() {
        ivReload.image = UIImage(named: "sync")
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
            ], completionHandler:
                { result in
                    switch result {
                    case .success( _):
                        self.ivReload.gone()
                        self.ivReload.removeAnimation()
                    case .failure( _):
                        self.ivReload.visible()
                        self.ivReload.removeAnimation()
                        self.setRetry()
                    }
                })
    }
    
    func setRetry() {
        ivReload.image = UIImage(named: "retry")
    }
    
}
