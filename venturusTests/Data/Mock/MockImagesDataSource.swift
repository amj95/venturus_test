//
//  MockImagesDataSource.swift
//  venturusTests
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation
@testable import venturus

class MockImagesRemoteDataSource: ImagesDataSource {
    
    static var INSTANCE: MockImagesRemoteDataSource? = nil
    var shouldReturnError = false
    var getDataWasCalled = false
    
    private init() {
    }
    
    static func getInstance() -> MockImagesRemoteDataSource {
        
        if (INSTANCE == nil) {
            INSTANCE = MockImagesRemoteDataSource()
        }
        
        return INSTANCE!
    }
    
    func getImages(onComplete: @escaping ([ImageData]) -> Void, onError: @escaping (Constants.ComunicationError) -> Void)  {
        getDataWasCalled = true
        if shouldReturnError {
            onError(.invalidJSON)
        } else {
//            let mockResponseData = [
//                SCNoticia(id: 1, title: "noticia 1", body: "body noiticia", image: "http://teste.com", views: 1, created_at: "11/11/2020")
//                ,SCNoticia(id: 2, title: "noticia 2", body: "body noiticia2", image: "http://teste2.com", views: 2, created_at: "22/11/2020")]
            let mockResponseData: [ImageData] = []
            onComplete(mockResponseData)
        }
    }
}
