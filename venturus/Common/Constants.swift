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
    
}
