//
//  ModelsTesting.swift
//  BeerTrackerTests
//
//  Created by Daniel Carracedo on 11/10/22.
//

import XCTest
@testable import BeerTracker

final class ModelsTesting: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelosStatusNetWork() throws {
        var status = StatusNetwork.none
        XCTAssertEqual(status, StatusNetwork.none)
        
        status = StatusNetwork.sending
        XCTAssertEqual(status, StatusNetwork.sending)
        
        status = StatusNetwork.success
        XCTAssertEqual(status, StatusNetwork.success)
        
        status = StatusNetwork.error
        XCTAssertEqual(status, StatusNetwork.error)
    }
    func testBeerModel() throws {
        let model = Beer(id: 1, name: "Beer", tagline: "Tagline Example", firstBrewed: "BrewExample", beerDescription: "Here nice slogan")
        XCTAssertEqual(model.id, 1)
        XCTAssertEqual(model.name, "Beer")
        XCTAssertEqual(model.tagline, "Tagline Example")
        XCTAssertEqual(model.firstBrewed, "BrewExample")
        XCTAssertEqual(model.beerDescription, "Here nice slogan")
    }
    
    func testChipModel() throws {
        let model = ChipModel(isSelected: false, title: "TitleTest", queryItem: URLQueryItem(name: "param", value: "value"))
        XCTAssertEqual(model.isSelected, false)
        XCTAssertEqual(model.title, "TitleTest")
        XCTAssertEqual(model.queryItem, URLQueryItem(name: "param", value: "value"))
    }
}
