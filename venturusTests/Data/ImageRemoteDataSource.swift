//
//  ImageRemoteDataSource.swift
//  venturusTests
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation
import XCTest
@testable import venturus

class ImageRemoteDataSource: XCTestCase {
    
    func test_successfull_request() {
        var results: [ImageData] = []
        let expectation = self.expectation(description: "waiting request")
        let requestValue = GetImages.RequestValues(page: 1)
        ImagesRemoteDataSource.getInstance().getImages(requestValue: requestValue, onComplete: {(ImageData) in
            results = ImageData
            expectation.fulfill()
        }, onError: {(Error) in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(results.count > 0)
    }
}


