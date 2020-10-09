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
    
    var viewModel: HomeViewModel?
    
    func test_loading() {
        viewModel = HomeViewModel(getImages: GetImages())
        let expectation = self.expectation(description: "waiting request")
        if let viewModel = viewModel {
            let subscriber = viewModel
                .$isLoading
                .sink(receiveValue: {
                    guard $0 == true else { return }
                    expectation.fulfill()
                })
            
            viewModel.loadData()
            wait(for: [expectation], timeout: 10)
            XCTAssertTrue(viewModel.isLoading == true)
        }
    }
    
}
