//
//  HomeViewModel.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation
import Combine

class HomeViewModel {
    
    var mGetImages: UseCase
    @Published var isLoading: Bool = false
    
    init(getImages: UseCase){
        mGetImages = getImages
    }
    
    func loadData() {
        isLoading = true
    }
    
}
