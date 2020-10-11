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
    
    private init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    
    static func getInstance(shouldReturnError: Bool) -> MockImagesRemoteDataSource {
        if(INSTANCE == nil){
            INSTANCE = MockImagesRemoteDataSource(shouldReturnError: shouldReturnError)
        }
        INSTANCE?.shouldReturnError = shouldReturnError
        
        return INSTANCE!
    }
    
    
    func getImages(requestValue: RequestValuesProtocol ,onComplete: @escaping ([ImageData]) -> Void, onError: @escaping (Constants.ComunicationError) -> Void)  {
        getDataWasCalled = true
        if shouldReturnError {
            onError(.invalidJSON)
        } else {
            if let fileLocation = Bundle.main.url(forResource: "success_request", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileLocation)
                    let jsonDecoder = JSONDecoder()
                    let dataFromJson = try jsonDecoder.decode(ImgurResponse.self, from: data)
                    onComplete(dataFromJson.data)
                } catch {
                    onError(.invalidJSON)
                }
            }
        }
    }
}
