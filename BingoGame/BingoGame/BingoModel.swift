//
//  BingoModel.swift
//  BingoGame
//
//  Created by 이선준 on 12/25/23.
//

import Foundation

let bingoSize: Int = 3


// 빙고 리스트
var bingoList: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

// 빙고 패널
struct Panel {
    var text: String = ""
    var isSame: Bool = false
    
    func printPanel() {
        print("\(text)  ", terminator: "")
    }
}

struct Bingo {
    var panels: [[Panel]] =
        [[Panel]](repeating: Array(repeating: Panel(), count: bingoSize), count: bingoSize)
    
    var verticalBingo: Int = 0
    var horizontalBingo: Int = 0
    var diagonalBingo: Int = 0
    
    var bingos: Int {
        get {
            return verticalBingo + horizontalBingo + diagonalBingo
        }
    }
    
    init() {
        bingoList.shuffle()
        
        for y in 0 ... (bingoSize - 1) {
            for x in 0 ... (bingoSize - 1) {
                panels[y][x].text = "\(bingoList[(bingoSize * y) + x])"
            }
        }
    }
    
    mutating func pressPanel(y: Int, x: Int) {
        if y <= 0 || bingoSize < y{
            return
        }
        if x <= 0 || bingoSize < x {
            return
        }
        
        self.panels[y - 1][x - 1].isSame = !panels[y - 1][x - 1].isSame
        
        checkAllBingos()
    }
    
    // 패널의 값들 출력해주는 함수
    func printPanelsTexts() {
        for y in 0 ... (bingoSize - 1) {
            for x in 0 ... (bingoSize - 1) {
                panels[y][x].printPanel()
            }
            print()
        }
        print()
    }
    
    // 패널이 O인지 X인지 출력해주는 함수
    func checkPanelsIsSame() {
        for y in 0 ... (bingoSize - 1) {
            for x in 0 ... (bingoSize - 1) {
                if panels[y][x].isSame == false {
                    print("X  ", terminator: "")
                } else {
                    print("O  ", terminator: "")
                }
            }
            print()
        }
        print()
    }
    
    
    func printBingos() {
        print("Bingo: \(bingos)\n")
    }
    
    
    func printScreen() {
        print("=========================================================")
        printPanelsTexts()
        checkPanelsIsSame()
        printBingos()
        print("=========================================================")
    }
    
    
    // check bingos
    
    mutating func checkVerticalLines() {
        verticalBingo = 0
        
        for x in 0 ... (bingoSize - 1) {
            var count: Int = 0
            for y in 0 ... (bingoSize - 1) {
                if panels[y][x].isSame == true {
                    count += 1
                }
            }
            if count == bingoSize {
                verticalBingo += 1
            }
        }
    }
    
    mutating func checkHorizontalLines() {
        horizontalBingo = 0
        
        for y in 0 ... (bingoSize - 1) {
            var count: Int = 0
            for x in 0 ... (bingoSize - 1) {
                if panels[y][x].isSame == true {
                    count += 1
                }
            }
            if count == bingoSize {
                horizontalBingo += 1
            }
        }
    }
    
    mutating func checkDiagonalLines() {
        diagonalBingo = 0
        
        var count: Int = 0
        
        for y in 0 ... (bingoSize - 1) {
            let x = y
            if panels[y][x].isSame == true {
                count += 1
            }
        }
        if count == bingoSize {
            diagonalBingo += 1
        }
    }
    
    mutating func checkAllBingos() {
        checkDiagonalLines()
        checkVerticalLines()
        checkHorizontalLines()
    }
}

var myBingo: Bingo = Bingo()

myBingo.pressPanel(y: 2, x: 1)
myBingo.printScreen()

myBingo.pressPanel(y: 2, x: 2)
myBingo.printScreen()

myBingo.pressPanel(y: 2, x: 3)
myBingo.printScreen()

myBingo.pressPanel(y: 1, x: 1)
myBingo.printScreen()

myBingo.pressPanel(y: 3, x: 3)
myBingo.printScreen()

myBingo.pressPanel(y: 1, x: 2)
myBingo.printScreen()

myBingo.pressPanel(y: 1, x: 3)
myBingo.printScreen()

myBingo.pressPanel(y: 1, x: 2)
myBingo.printScreen()
