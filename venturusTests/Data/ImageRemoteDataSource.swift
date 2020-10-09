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
    
    var viewModel: HomeViewModel?
    
    func test_successfull_request() {
        var results: [ImageData] = []
        let expectation = self.expectation(description: "waiting request")
        ImagesRemoteDataSource.getInstance().getImages(onComplete: {(ImageData) in
            results = ImageData
            expectation.fulfill()
        }, onError: {(Error) in
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(results.count > 0)
    }
}


