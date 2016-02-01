//
//  ViewController.swift
//  Calculator
//
//  Created by work on 12/5/15.
//  Copyright (c) 2015 work. All rights reserved.
// ignore weak for now; @IBOutlet is there 2 create the dot in the gutter? ignore 4 now.

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var display: UILabel!

    
    @IBOutlet weak var historyDisplay: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    private let defaultDisplayText = "0"
    var mSetter: String = "M"
    var brain = CalculatorBrain()

    func exampleFxnReturnTrue() -> Bool {
        return true
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
 
        if userIsInTheMiddleOfTypingANumber {
            if digit != "." || display.text!.rangeOfString(".") == nil {
                display.text = display.text! + digit
                print("display.text in first block is: \(display.text)")
            }
        } else {
            display.text! = digit
            print("display.text! in second block is: \(display.text!)")
//            print("")
            userIsInTheMiddleOfTypingANumber = true
        }
        appendHistory(digit)

    }
    
    func appendHistory(operandOrOperator: String) {
        if historyDisplay.text != nil {
            historyDisplay.text = historyDisplay.text! + operandOrOperator
        } else {
            historyDisplay.text = operandOrOperator
        }
    }

    
//    var operandStack = Array<Double>()
//    operate: perform a math process (+, −, ×, ÷). when a certain button pressed, perform the specified math process.
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.pushOperand(operation){
                displayValue = result
                appendHistory(operation)
                
            } else {
                displayValue = 0
            }
        }


    }


    @IBAction func clear() {
//        historyDisplay.text! = "something"
//        print(historyDisplay.text! = "SOME")
                brain.clearStack()
                userIsInTheMiddleOfTypingANumber = false
//                display.text = defaultDisplayText
                historyDisplay.text! = " "
    }
    
    //enter will append the displayValue to the end of the array & set the userinmid of number to false since we want a new num to appear fresh and not append to the last num input
    //this enter should be set to private
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        displayValue = brain.pushOperand(displayValue!)
    }
    
    //displayValue is the number format of the string value in the display.
    var displayValue: Double? {
        get{
//            print("this is display.text in enter: \(display.text!)")
            if let displayValue = NSNumberFormatter().numberFromString(display.text!) {
                return displayValue.doubleValue
            } else {
                clear()
                userIsInTheMiddleOfTypingANumber = false
                return nil
            }
        }
        set {
            if let actualValue = newValue {
                display.text = "\(actualValue)"
            } else {
                // to be determined
//                DC PROJECT FOR WHAT TO SET TO HERE IF NIL PASSED IN
            }
            
            
//            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
//            historyDisplay.text = brain.description + " ="
        }
    }
    
    @IBAction func storeVariable(sender: UIButton) {

            if displayValue != nil {
                brain.variableValues["\(mSetter)"] = displayValue
            }
        displayValue = brain.evaluate()

        userIsInTheMiddleOfTypingANumber = false
    }
    
    @IBAction func pushVariable(sender: UIButton) {
        brain.pushOperand(mSetter)
        
        displayValue = brain.evaluate()
        
    }
    

}

