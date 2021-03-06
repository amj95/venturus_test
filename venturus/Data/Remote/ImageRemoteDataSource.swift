//
//  ImageRemoteDataSource.swift
//  venturus
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation
/*
 Implementation of data source that fetches images from remote server
 */
class ImagesRemoteDataSource: ImagesDataSource {
    
    private static var INSTANCE: ImagesDataSource? = nil
    private let basePath = Constants.API_URL + "/gallery/top/week"
    private var session = URLSession(configuration: Constants.configuration)
    
    //Prevents direct instantiation
    private init() {
        session = URLSession(configuration: Constants.configuration)
    }
    
    public static func getInstance() -> ImagesDataSource {
        if (INSTANCE == nil) {
            INSTANCE = ImagesRemoteDataSource()
        }
        return INSTANCE!
    }
    
    func getImages(requestValue: RequestValuesProtocol, onComplete: @escaping ([ImageData]) -> Void, onError: @escaping (Constants.ComunicationError) -> Void) {
        let request = requestValue as! GetImages.RequestValues
        
        guard let url = URL(string: basePath + "/\(request.page)") else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response:URLResponse?, error:Error?) in
            
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    var str = String(data: data, encoding: .utf8)
                    str = str?.replacingOccurrences(of: "null", with: "\"\"")
                    let strData: Data? = str!.data(using: .utf8)
                    do {
                        let entity = try JSONDecoder().decode(ImgurResponse.self, from: strData!)
                        onComplete(entity.data.filter({$0.images != nil }))
                    } catch {
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
}

