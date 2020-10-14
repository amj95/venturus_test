//
//  ImageCellViewModel.swift
//  venturus
//
//  Created by antonio marcos on 14/10/20.
//

import Foundation


class ImageCellViewModel {
    
    var up: String
    var comment: String
    var views: String
    var imageUrl: String?
    
    init(up: String, comment: String, views: String, imageUrl: String? = nil) {
        self.up = up
        self.comment = comment
        self.views = views
        self.imageUrl = imageUrl
    }
    
}
