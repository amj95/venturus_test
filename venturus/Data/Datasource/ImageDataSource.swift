//
//  ImageDataSource.swift
//  venturus
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation

protocol ImagesDataSource {
    func getImages(onComplete: @escaping ([ImageData]) -> Void, onError: @escaping (Constants.ComunicationError) -> Void)
}
