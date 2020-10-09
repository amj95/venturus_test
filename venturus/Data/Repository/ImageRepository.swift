//
//  ImageRepository.swift
//  venturus
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation
/*
 Concrete implementation of a repository to load images from data source into cache
 */
class ImagesRepository: ImagesDataSource {
    
    private static var INSTANCE: ImagesRepository? = nil
    private var mRemoteDataSource: ImagesDataSource
    //This variable store all previous data for instant responses
    private var mCache = [String : ImageData]()
    
    private init(remoteDataSource: ImagesDataSource){
        mRemoteDataSource = remoteDataSource
    }
    
    public static func getInstance(remoteDataSource: ImagesDataSource) -> ImagesDataSource {
        if(INSTANCE == nil){
            INSTANCE = ImagesRepository(remoteDataSource: remoteDataSource)
        }
        return INSTANCE!
    }
    
    func getImages(onComplete: @escaping ([ImageData]) -> Void, onError: @escaping (Constants.ComunicationError) -> Void) {
        mRemoteDataSource.getImages(onComplete: {(ImageData) in
            onComplete(ImageData)
            self.refreshCache(images: ImageData)
        }, onError: {(Error) in
            onError(Error)
        })
    }
    
    func refreshCache(images: [ImageData]){
        for image in images {
            mCache[image.id] = image
        }
    }
}
