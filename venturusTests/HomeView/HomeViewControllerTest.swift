//
//  HomeViewControllerTest.swift
//  venturusTests
//
//  Created by antonio marcos on 11/10/20.
//

import Foundation
import XCTest
@testable import venturus

class HomeViewControllerTest: XCTestCase {
    
    func makeSUT() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "homeViewController") as! HomeViewController
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testRender() {
        let sut = makeSUT()
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.collectionView.numberOfItems(inSection: 0) == 0)
        XCTAssertEqual(sut.navigationItem.title, "<Top Weekly>".localized)
        XCTAssertEqual(sut.lbError.text, "")
        XCTAssertTrue(sut.viewError.isHidden)
    }
    
    func testLoadCalled() {
        let sut = makeSUT()
        sut.viewDidLoad()
        
        XCTAssertTrue(sut.mHomeViewModel.isLoading)
    }
    
    func testLoadData() {
        let sut = makeSUT()
        
        sut.loadData()
        XCTAssertTrue(sut.mHomeViewModel.isLoading)
    }
}
