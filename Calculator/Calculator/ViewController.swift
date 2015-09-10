//
//  ViewController.swift
//  Calculator
//
//  Created by Suriyanto Bongso on 9/1/15.
//  Copyright (c) 2015 Suriyanto Bongso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var typing = false
    var inDecimalPoint = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = processDigit(sender.currentTitle!)
        appendHistory(digit)
        
        if typing {
            display.text = display.text! + digit
        } else {
            display.text = digit
            typing = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if typing {
            enter()
        }
        
        appendHistory(operation)
        switch operation {
        case "✖️": performOperation { $0 * $1 }
        case "➗": performOperation { $1 / $0 }
        case "➕": performOperation { $0 + $1 }
        case "➖": performOperation { $1 - $0 }
        case "✔️": performOperation { sqrt($0) }
        case "sin": performOperation { sin($0) }
        case "cos": performOperation { cos($0) }
        default: break
        }
    }
    
    @IBAction func pi(sender: UIButton) {
        if typing {
            enter()
        }
        display.text = "3.14"
        enter()
    }
    
    @IBAction func enter() {
        typing = false
        operandStack.append(displayValue)
        appendHistory(", ")
        println("operandStack = \(operandStack)")
    }
    
    private func appendHistory(c: String) {
        history.text = history.text! + c
    }
    
    private func processDigit(digit: String) -> String {
        if digit == "." && find(display.text ?? "", ".") != nil {
            return ""
        } else {
            return digit
        }
    }
    
    private func performOperation(op: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = op(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(op: Double -> Double) {
        if (operandStack.count >= 1) {
            displayValue = op(operandStack.removeLast())
            enter()
        }
    }

    var operandStack = Array<Double>()
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            typing = false
        }
    }
}
