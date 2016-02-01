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
    
    func testExample() {
        // This is an example of a functional test case.
//        XCTAssert(true, "Pass")
        let sum = 1 + 2
        XCTAssertEqual(3, sum, "sum should be 3")
        XCTAssertTrue(sum == 3, "Value should be 3")
        XCTAssertNotNil(sum)
        
    }
    
    func ignoreExampleShouldFail() {
        let sum = 1 + 3
        XCTAssertEqual(2, sum, "Value should be 2")

    }
    
//    this is the correct way to test the viewctrllr if doing UI Automation
//    func testExampleReturnTrue() {
//        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
//        var vc = storyboard.instantiateViewControllerWithIdentifier("View Ctrllr") as! ViewController
//        vc.loadView()
//        XCTAssertTrue(vc.exampleFxnReturnTrue(), "should return true")
//    }
//    
//    func testClear() {
//
//        
//        
//       let myCtrllr = ViewController()
//        myCtrllr.clear()
//        XCTAssertEqual(myCtrllr.historyDisplay.text, " ")
//    }

//    func testOperate() {
//        
//    }
//    
//    func testAppendHistory() {
//        
//    }
//
//    
    
}
