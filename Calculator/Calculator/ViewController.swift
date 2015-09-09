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

    var typing = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
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
        
        switch operation {
        case "✖️": performOperation { $0 * $1 }
        case "➗": performOperation { $1 / $0 }
        case "➕": performOperation { $0 + $1 }
        case "➖": performOperation { $1 - $0 }
        case "✔️": performOperation { sqrt($0) }
        default: break
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
    
    @IBAction func enter() {
        typing = false
        operandStack.append(displayValue)
        println("operantStack = \(operandStack)")
    }
    
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