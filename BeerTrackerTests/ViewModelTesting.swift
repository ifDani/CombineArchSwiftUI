//
//  ViewModelTesting.swift
//  BeerTrackerTests
//
//  Created by Daniel Carracedo on 11/10/22.
//

import XCTest
import Combine
import SwiftUI
@testable import BeerTracker

final class ViewModelTesting: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeViewModel() throws {
        cancellables = []
        let expectation = self.expectation(description: "homeexpectation")

        let vm = HomeViewModel()
        
        XCTAssertNotNil(vm)

        vm.getAllBeers()
        
        vm.$status
            .sink { status in
                
                if status == StatusNetwork.success{
                    expectation.fulfill()
                }
                
            }
            .store(in: &self.cancellables)
        
        self.waitForExpectations(timeout: 60)

    }
    
    func testDetailViewModel() throws {
        cancellables = []
        let expectation = self.expectation(description: "detail")

        let vm = DetailViewModel()
        XCTAssertNotNil(vm)

        vm.getBeer()

        vm.$status
            .sink { status in

                if status == StatusNetwork.success {
                    expectation.fulfill()
                }

            }
            .store(in: &self.cancellables)

        self.waitForExpectations(timeout: 60)

    }
    
}
