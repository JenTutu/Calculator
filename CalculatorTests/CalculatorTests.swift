//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by work on 12/5/15.
//  Copyright (c) 2015 work. All rights reserved.
//

import UIKit
import XCTest
@testable import Calculator


class CalculatorTests: XCTestCase {

    var controller: ViewController?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
//        XCTAssert(true, "Pass")
        let sum = 1 + 2
        XCTAssertEqual(3, sum, "sum should be 3")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testClear() {
       let myCtrllr = ViewController()
        myCtrllr.clear()
        XCTAssertEqual(myCtrllr.historyDisplay.text, " ")
       
    }
    
}
