//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by work on 1/10/16.
//  Copyright (c) 2016 work. All rights reserved.
//

import Foundation
class CalculatorBrain
{//operand: a number operator: is like +, -, etc.; an Op, defined below, can be an operand, or a type of operation
    var variableValues: Dictionary<String, Double>
//    must set variables, either in init or when the variable is declared
//    also, always clean and/or build the project
    var opStack = [Op]() //this is short hand for creating an array of Op types; the opStack holds operands and operators that we will display to the user
    private var knownOps = [String:Op]() //this is like a dictionary that stores definitions for the operators. It has Strings for keys and Ops for values
    
    init() { //when we create a calculator, init with this dictionary:
                var knownOps = ["":Op.Operand(1.0)]
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        knownOps["sin"] =  Op.UnaryOperation("sin", sin)
        knownOps["cos"] =  Op.UnaryOperation("cos", cos)
//        description: String = ""
        variableValues = ["": 1.0]
//        opStack = [Op.Operand(1.0)]
//        var (result, ops) = ("", opStack)
//        var remainingOps = ops
//         var current: String? = ""
    }
    
    
//    init() {
//        func learnOp (op: Op) {
//            knownOps[op.description] = op
//        }
//        //knownOps["×"] = Op.BinaryOperation("×") { $0 * $1 }
//        //knownOps["×"] = Op.BinaryOperation("×", *)
//        learnOp(Op.BinaryOperation("×", *))
//        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
//        //knownOps["+"] = Op.BinaryOperation("+") { $0 + $1 }
//        knownOps["+"] = Op.BinaryOperation("+", +)
//        knownOps["−"] = Op.BinaryOperation("−") { $1 - $0 }
//        //knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
//        knownOps["√"] = Op.UnaryOperation("√", sqrt)
//    }
    /*private*/ enum Op {
        case Operand(Double) //This says that the value of the operand is a string (this has nothing to do with dictionaries)
        case Variable(String)
        case UnaryOperation(String, Double -> Double) //this is a fxn see 13min; a unaryOPeration is a string and has a fxn associated with it. that fxn takes in a double and returns a double
        case BinaryOperation(String, (Double, Double) -> Double) //i think this means that in the case of a binary operation, take in a string and perform another function that takes in two doubles and returns a double
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return "\(symbol)"
                case .BinaryOperation(let symbol, _):
                    return "\(symbol)"
                case .Variable(let symbol):
                    return "\(symbol)"
                }
            }
        }
    }
    
    var description: String {
        get {
            var (result, ops) = ("", opStack)
            repeat {
                var current: String?
                //                (current!, ops) = description(ops)
                result = result == "" ? current! : "\(current!), \(result)"
            } while ops.count > 0
            return result
        }
    }

//    how to set an Op value
    private func opTestFunc(op: Op) {
        let  x: Op = .Variable("my variable")
        
        let description: String = x.description //op.description
        print (description)
    }
    
    //    when u type args into function, unless the arg is a class instance, the arg is a copy and is therefore immutable; also there is an implicit let in front of such args
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty {
            //here we make a copy of ops and store it in a var. a var is mutable and thus we can perform removeLast() on a mutable variable
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation): //the _ is a symbol for an unamed variable
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            case .Variable(let symbol):
                if let variableValue = variableValues[symbol] {
                    return (variableValue, remainingOps)
                } else {
                    return (nil, remainingOps)
                }
            }
        }
        return (nil, ops)
    }
    //To evaluate a function, you replace the variable with the value given
    //        this needs to return an optional bc the person could hit an operator without first typing in operands
    func evaluate() -> Double? {
        
        let (result, remainder) = evaluate(opStack)
        return result
    }
    
    //    review recursion, tuples
    //    this fxn pushes the operand onto the stack
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    //    this is supposed to push the variable onto the internal stack & return the result of evaluate
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
    
    //this will perform the operation based on which operator is sent
    //    why are we separating push operand and pushing an operator?
    func performOperation(symbol: String) {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
    
    func clearStack() {
        opStack = [Op]()
    }
    
}
