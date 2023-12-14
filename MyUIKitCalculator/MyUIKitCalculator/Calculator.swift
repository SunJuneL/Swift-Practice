//
//  Calculator.swift
//  MyUIKitCalculator
//
//  Created by 이선준 on 12/14/23.
//

import Foundation

enum Modes {
    case OperMode
    case CalMode
    case NumMode
}

enum Opers {
    case Add
    case Sub
    case Mul
    case Div
    case Equal
    case None
}

class Calculator {
    // ================================= 변수 =================================
    var formula: [String] = []
    var nums: [Int] = []
    var opers: [Opers] = []
    
    var setOper: Opers = .None
    var mode: Modes = .NumMode
    var screen: String = "0"
    var now: Int = 0
    var result: Int = 0
    
    var lastNum: Int = 0
    var lastOper: Opers = .None
    
    func clear() {
        screen = "0"
    }
    
    func clearEverything() {
        formula.removeAll()
        nums.removeAll()
        opers.removeAll()
        
        mode = .NumMode
        screen = "0"
        now = 0
        result = 0
        setOper = .None
    }
    
    func pressNumber(tag: Int) {
        print("Press \(tag) button !!")
        // 1. 태그 범위 체크
        if tag < 0 || 9 < tag {
            return
        }
        
        // 현재 모드가 계산모드라면 AC
        if mode == .CalMode {
            clearEverything()
            mode = .NumMode
        // 현재 모드가 연산자모드라면, screen = "0"
        } else if mode == .OperMode {
            screen = "0"
            mode = .NumMode
            opers.append(setOper)
        }
        
        // screen 변경
        if screen == "0" {
            screen = "\(tag)"
        } else {
            screen += "\(tag)"
        }
    } // pressNum() 끝
    
    
    func checkOper() {
        /*
         setOper에 따라 다르게 작동
             1. None이라면, formula와 nums에 now 저장
             2. +, - 라면,
                 (1). formula에 setOper 저장
                 (2). formula에 now 저장
                 (3). + 라면, nums에 now 저장
                 (3). - 라면, nums에 -1 * now 저장
             2. x, ÷ 라면,
                 (1). formula에 setOper 저장
                 (2). formula에 now 저장
                 (3). × 라면, nums 마지막 요소 *= now
                 (4). ÷ 라면,
                     -1. now가 0이라면, nums = nil
                     -2. now가 0이 아니라면, nums /= now
         */
        if opers.count == 0 {
            formula.append(String(now))
            nums.append(now)
            return
        }
        let setOper = opers[opers.count - 1]
        
        switch setOper {
        case .Add:
            formula.append("﹢")
            formula.append(String(now))
            nums.append(now)
            
        case .Sub:
            formula.append("-")
            formula.append(String(now))
            nums.append(now)
            
        case .Mul:
            formula.append("*")
            formula.append(String(now))
            nums[nums.count - 1] = nums[nums.count - 1] * now
            opers.removeLast()
            
        case .Div:
            formula.append("÷")
            formula.append(String(now))
            if now == 0 {
                nums[nums.count - 1] = 0
            } else {
                nums[nums.count - 1] = nums[nums.count - 1] / now
            }
            opers.removeLast()
            
        default:
            print("잘못된 setOper 케이스 입니다!")
            break
        }
    } // checkOper() 끝
    
    func calculateResult() {
        result = nums[0]
        
        if opers.count == 0 {
            return
        }
        
        for i in 0 ..< opers.count {
            if opers[i] == .Add {
                result += nums[i + 1]
            } else {
                result -= nums[i + 1]
            }
        }
    }
    
    func pressOperator(tag: Int) {
        // 태그 범위 체크
        if tag < 1 || tag > 4 {
            return
        }
        
        /*
         연산자 모드가 아니라면
             1. 현재 screen 값을 now로 받음
             2. now 값이 nil 이라면, screen = "오류" 하고 리턴
             3. setOper에 따라 다른 동작을 하는 함수 checkOper() 호출
             4. result 구하는 함수 getResult() 호출
             5. result 값이 nil 이라면, screen = "오류" 하고 리턴
             6. 연산자 모드로 변경
         */
        if mode != .OperMode {
            now = Int(screen) ?? 0
            checkOper()
            calculateResult()
            mode = .OperMode
        }
        
        // tag에 따라 setOper 및 screen 할당 및 수정
        switch tag {
        case 1:
            setOper = .Add
            print("Press + button !!")
            screen = "\(result)"
            
        case 2:
            setOper = .Sub
            print("Press - button !!")
            screen = "\(result)"
            
        case 3:
            setOper = .Mul
            print("Press * button !!")
            screen = "\(nums[nums.count - 1])"
            
        case 4:
            setOper = .Div
            print("Press / button !!")
            screen = "\(nums[nums.count - 1])"
            
        default:
            break
        }
    } // pressOper() 끝
    
    func pressEqual() {
        print("Press = button !!")
        /*
         계산 모드가 아니라면
             1. 현재 screen 값을 now로 받음
             2. now 값이 nil 이라면, screen = "오류" 하고 리턴
             3. setOper에 따라 다른 동작을 하는 함수 checkOper() 호출
             4. result 구하는 함수 getResult() 호출
             5. screen = result
             6. 계산 모드로 변경
         계산 모드라면
             1. now와 setOper에 따라 result 계산
         */
        if mode == .OperMode {
            opers.append(setOper)
        }
        
        if mode != .CalMode {
            now = Int(screen) ?? 0
            checkOper()
            calculateResult()
            mode = .CalMode
            lastNum = now
            lastOper = setOper
        }
        else {
            switch lastOper {
            case .Add:
                result += lastNum
                            
            case .Sub:
                result -= lastNum
                                            
            case .Mul:
                result *= lastNum
                                                
            case .Div:
                if lastNum == 0 {
                    result = 0
                } else {
                    result /= lastNum
                }
                                                    
            default:
                break
            }
        }
        screen = "\(result)"
    }
}
