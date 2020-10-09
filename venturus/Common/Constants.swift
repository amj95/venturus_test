//
//  Constants.swift
//  venturus
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation

class Constants {
    
    enum ComunicationError {
        case url
        case taskError(error : Error)
        case noResponse
        case noData
        case responseStatusCode(code: Int)
        case invalidJSON
    }
    
    static var ClientID = "ad3a861e698cb91"
    var ClientSecret = "02c7efa54ab64564582ccc54792ed061ebb85e86"
    var path = "https://api.imgur.com/3/gallery/top/week"
    static var API_URL = "https://api.imgur.com/3"
    
    static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type":"application/json", "Authorization":"Client-ID \(ClientID) szQXjTe2FJ6teB27KmmTSUNc5XNcA6txnSnHKNVy5vqUaym3e9NmBQmNAYm4"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
        
    }()
    
}
