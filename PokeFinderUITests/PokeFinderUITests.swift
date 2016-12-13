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
        waitForElementToAppear(format: "isHittable = true", element: hiltonHotel, time: 15.0)
        XCTAssert(hiltonHotel.exists)
    }
    
    func testZoomInOut() {
    
        zoomIn()
        
        //zoom out
        app.maps.element.pinch(withScale: 0.15, velocity: -3)
        
//     fix test with false predicate for element to disapear
        waitForElementToAppear(format: "exists = false", element: hiltonHotel, time: 15.0)
        XCTAssertFalse(hiltonHotel.exists)
        
    }
    
    func testMapSwipe(){
        zoomIn()
        while !waterBar.exists {
            app.swipeLeft()
        }
        
        XCTAssert(waterBar.exists)
    }
    
    
    func waitForElementToAppear(format: String, element: AnyObject, time: Double){
        let exists = NSPredicate(format: format)
        expectation(for: exists, evaluatedWith:element, handler: nil)
        waitForExpectations(timeout: time, handler: nil)
    }

    
}
