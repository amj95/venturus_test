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
    @Published var result: String = ""
    @Published var dataArray: [ImageData] = []
    
    init(getImages: UseCase){
        mGetImages = getImages
    }
    
    func loadData() {
        isLoading = true
        let requestValue = GetImages.RequestValues()
        mGetImages.executeUseCase(requestValues: requestValue, onComplete: {(Response) in
            self.isLoading = false
            DispatchQueue.main.async {
                let response = Response as! GetImages.ReponseValues
                self.dataArray = response.mList
                if (response.mList.count == 0) {
                    self.result = "<No Images>".localized
                }
            }
            
        }, onError: {(Error) in
            self.isLoading = false
            DispatchQueue.main.async {
                self.result = "<Failed Load>".localized
            }
        })
    }
    
}
