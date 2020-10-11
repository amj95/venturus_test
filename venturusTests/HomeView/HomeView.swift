//
//  ImageRemoteDataSource.swift
//  venturusTests
//
//  Created by antonio marcos on 09/10/20.
//

import Foundation
import XCTest
@testable import venturus

class HomeView: XCTestCase {
//    let mockDataSource = MockImagesRemoteDataSource.getInstance(shouldReturnError: false)
    var viewModel: HomeViewModel?
    
    func test_success_request() {
        let mockDataSource = MockImagesRemoteDataSource.getInstance(shouldReturnError: false)
        mockDataSource.getDataWasCalled = false
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
            XCTAssertTrue(viewModel.dataArray.count > 0)
            XCTAssertTrue(viewModel.result == "")
            XCTAssertTrue(viewModel.isLoading == false)
        }
    }
    
    func test_error_request() {
//        let mockDataSource = MockNoticiasRemoteDataSource.getInstance(shouldReturnError: true)
//        mockDataSource.getDataWasCalled = false
//        viewModel = ViewNoticiasViewModel(getNoticias: GetNoticias(noticiasRepository: NoticiasRepository.getInstance(remoteDataSource: mockDataSource)))
//        let expectation = self.expectation(description: "waiting request")
//        if let viewModel = viewModel {
//            let subscriber = viewModel
//                .$resultString
//                .sink(receiveValue: {
//                    guard $0.count > 0 else { return }
//                    expectation.fulfill()
//                })
//
//            viewModel.loadData()
//            wait(for: [expectation], timeout: 10)
//            XCTAssertTrue(viewModel.noticiasData.count == 0)
//            XCTAssertTrue(viewModel.resultString == "<Erro ao carregar dados>".localized)
//            XCTAssertTrue(viewModel.isLoading == false)
//            XCTAssertTrue(mockDataSource.getDataWasCalled == true)
//        }
    }
}


