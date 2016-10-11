//
//  PokeFinderUITests.swift
//  PokeFinderUITests
//
//  Created by Igor Dorovskikh on 9/29/16.
//  Copyright © 2016 Devslopes. All rights reserved.
//

import XCTest

class PokeFinderUITests: XCTestCase {
    let app = XCUIApplication()
    
    
    override func setUp() {
        super.setUp()
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func handleLocation(){
        addUIInterruptionMonitor(withDescription: "Allow Location") { (alert) -> Bool in
            alert.buttons["Allow"].tap()
            return true
        }
        //perfrom tap here
        app.tap()
        

    }
    
    func testExample() {
    
        //zoom in
        app.maps.element.pinch(withScale: 1.5, velocity: 3)
        
        let kingOfThaiNoodleHouseElement = app.maps.otherElements["Pushkin Museum"]

        let exists = NSPredicate(format: "isHittable = true")
        expectation(for: exists, evaluatedWith:kingOfThaiNoodleHouseElement, handler: nil)
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssert(kingOfThaiNoodleHouseElement.exists)
        
        //zoom out
        app.maps.element.pinch(withScale: 0.15, velocity: -3)
        XCTAssertFalse(kingOfThaiNoodleHouseElement.exists)

        
    }
    
}
