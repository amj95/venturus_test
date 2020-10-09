//
//  HomeView.swift
//  venturusTests
//
//  Created by antonio marcos on 08/10/20.
//

import Foundation
import XCTest
@testable import venturus

class HomeView: XCTestCase {
    
    let mockDataSource = MockImagesRemoteDataSource.getInstance()
    var viewModel: HomeViewModel?
    
    override func setUp() {
        viewModel = HomeViewModel(getImages: GetImages(imagesRepository: ImagesRepository.getInstance(remoteDataSource: mockDataSource)))
    }
    
    func test_success_request() {
        let mockDataSource = MockImagesRemoteDataSource.getInstance()
        mockDataSource.getDataWasCalled = false
        mockDataSource.shouldReturnError = false
        viewModel = HomeViewModel(getImages: GetImages(imagesRepository: ImagesRepository.getInstance(remoteDataSource: mockDataSource)))
        let expectation = self.expectation(description: "waiting request")
        if let viewModel = viewModel {
            let subscriber = viewModel
                .$dataArray
                .sink(receiveValue: {
                    guard $0.count > 0 else { return }
                    expectation.fulfill()
                })
            
            viewModel.loadData()
            wait(for: [expectation], timeout: 10)
            XCTAssertTrue(viewModel.dataArray.count == 2)
            XCTAssertTrue(viewModel.result == "")
            XCTAssertTrue(viewModel.isLoading == false)
            XCTAssertTrue(mockDataSource.getDataWasCalled == true)
        }
    }
    
    func test_error_request() {
        
        mockDataSource.getDataWasCalled = false
        mockDataSource.shouldReturnError = true
        viewModel = HomeViewModel(getImages: GetImages(imagesRepository: ImagesRepository.getInstance(remoteDataSource: mockDataSource)))
        let expectation = self.expectation(description: "waiting request")
        if let viewModel = viewModel {
            let subscriber = viewModel
                .$result
                .sink(receiveValue: {
                    guard $0.count > 0 else { return }
                    expectation.fulfill()
                })
            
            viewModel.loadData()
            wait(for: [expectation], timeout: 10)
            XCTAssertTrue(viewModel.dataArray.count == 0)
            XCTAssertTrue(viewModel.result == "<Failed Load>".localized)
            XCTAssertTrue(viewModel.isLoading == false)
            XCTAssertTrue(mockDataSource.getDataWasCalled == true)
        }
    }
    
}


