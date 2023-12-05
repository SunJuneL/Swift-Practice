//
//  Calculator.swift
//  MyCalculator
//
//  Created by 이선준 on 12/4/23.
//

import Foundation

class Calculator {
    var previousNumber: Int = 0     // 이전에 저장된 숫자
    var currentNumber: Int = 0      // 현재 저장된 숫자
    
    // -1: None,  0: Equal,  1: Add,  2: Sub,  3: Mul,  4: Div
    var operatorType: Int = -1
    
    // 입력한 숫자를 추가해주는 함수
    func getNumberFromScreen(senderTag: Int) {
        currentNumber = currentNumber * 10 + senderTag
        print("previousNumber = \(previousNumber)    ||    currentNumber = \(currentNumber)    ||    oper = \(operatorType)")
        print("========================================================================")
    }
    
    // 연산자 타입을 저장해주는 함수
    func setOperator(senderTag: Int) {
        operatorType = senderTag
    }
    
    func calculate() {
        if operatorType == -1 {         // 처음
            previousNumber = currentNumber
            currentNumber = 0
            print("previousNumber = \(previousNumber)    ||    currentNumber = \(currentNumber)    ||    oper = \(operatorType)")
            print("========================================================================")
        } else if operatorType == 0 {   // equal
            // 내용 추가
        } else if operatorType == 1 {   // add
            print("\(previousNumber) + \(currentNumber) = \(previousNumber + currentNumber)")
            print("========================================================================")
            previousNumber += currentNumber
            currentNumber = 0
        } else if operatorType == 2 {   // sub
            print("\(previousNumber) - \(currentNumber) = \(previousNumber + currentNumber)")
            print("========================================================================")
            previousNumber -= currentNumber
            currentNumber = 0
        } else if operatorType == 3 {   // mul
            
        } else if operatorType == 4 {   // div
            // 내용 추가
        } else {                        // error
            print("지랄하지마세요~ㅎㅎㅗ")
        }
    }
}
