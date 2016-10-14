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
    let hiltonHotel = XCUIApplication().maps.otherElements["Hilton Hotel"]
    let waterBar = XCUIApplication().maps.otherElements["Waterbar"]

    
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
    
    func zoomIn(){
        app.maps.element.pinch(withScale: 1.5, velocity: 3)
        
        let exists = NSPredicate(format: "isHittable = true")
        expectation(for: exists, evaluatedWith:hiltonHotel, handler: nil)
        waitForExpectations(timeout: 15.0, handler: nil)
        
        XCTAssert(hiltonHotel.exists)

    }
    
    func testZoomInOut() {
    
        zoomIn()
        
        //zoom out
        app.maps.element.pinch(withScale: 0.15, velocity: -3)
        
//     fix test with false predicate for element to disapear
        
        let does_not_exists = NSPredicate(format: "exists = false")
        expectation(for: does_not_exists, evaluatedWith:hiltonHotel, handler: nil)
        waitForExpectations(timeout: 15.0, handler: nil)

        
        XCTAssertFalse(hiltonHotel.exists)
        
    }
    
    func testMapSwipe(){
        zoomIn()
        while !waterBar.exists {
            app.swipeLeft()
        }
        
        XCTAssert(waterBar.exists)
    }
    
}
