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
    var page: Int = 1
    
    init(getImages: UseCase){
        mGetImages = getImages
    }
    
    func loadData() {
        isLoading = true
        let requestValue = GetImages.RequestValues(page: self.page)
        mGetImages.executeUseCase(requestValues: requestValue, onComplete: {(Response) in
            self.isLoading = false
            DispatchQueue.main.async {
                let response = Response as! GetImages.ReponseValues
                self.dataArray.append(contentsOf: response.mList)
                if (response.mList.count == 0) {
                    self.result = "<No Images>".localized
                }
                self.page = requestValue.page + 1
            }
            
        }, onError: {(Error) in
            self.isLoading = false
            DispatchQueue.main.async {
                self.result = "<Failed Load>".localized
                self.dataArray = []
            }
        })
    }
    
}
