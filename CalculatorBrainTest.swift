//
//  CalculatorBrainTest.swift
//  Calculator
//
//  Created by Jen Oseitutu on 2/1/16.
//  Copyright © 2016 work. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorBrainTest: XCTestCase {

    var brain: CalculatorBrain?
    
    override func setUp() {
        super.setUp()
        brain = CalculatorBrain()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPushOperand() {
       let result = brain?.pushOperand(7.0)
        XCTAssertEqual(result, 7.0)
    }
    
    func testPushOperandStringVersion() {
        brain!.variableValues["x"] = 8.0
        let result = brain?.pushOperand("x")
        XCTAssertEqual(result, 8.0)
    }

    func testThatClearRemovesContentsOfOpStack() {
        brain!.pushOperand(22.0)
        brain!.clearStack()
        XCTAssertTrue(brain!.opStack.isEmpty)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
