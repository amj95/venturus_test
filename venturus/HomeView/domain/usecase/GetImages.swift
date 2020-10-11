//
//  GetImages.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation
/*
 Fetches the list of images
 */
class GetImages: UseCase {
    
    private var mImagesRepository: ImagesDataSource
    
    init(imagesRepository: ImagesDataSource){
        mImagesRepository = imagesRepository
    }
    
    func executeUseCase(requestValues: RequestValuesProtocol, onComplete: @escaping (ResponseValueProtocol) -> Void, onError: @escaping (Constants.ComunicationError) -> Void) {
        mImagesRepository.getImages(requestValue: requestValues, onComplete: {(ImagesData) in
            let response: ReponseValues = ReponseValues(responseData: ImagesData)
            onComplete(response)
        }, onError: {(Error) in
            onError(Error)
        })
    }
    
    class RequestValues: RequestValuesProtocol {
        var page: Int
        
        init(page: Int) {
            self.page = page
        }
    }
     
    class ReponseValues: ResponseValueProtocol {
        var mList: [ImageData]
        
        init(responseData: [ImageData]) {
            mList = responseData
        }
    }
}
