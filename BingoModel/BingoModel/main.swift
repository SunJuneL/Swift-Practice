import Foundation

let bingoSize: Int = 3

struct Panel {
    var isCorrect: Bool = false
    var content: String = ""
    var number: Int = 0
    
    func printDetail() {
        print("내용: \(content), 확인: \(isCorrect)")
    }
}

struct Bingo {
    // 패널s
    var panels: [[Panel]]
        = Array<[Panel]>(repeating: Array<Panel>(repeating: Panel(), count: 3), count: 3)
    
    // 빙고 개수
    var bingoCount = 0
    
    init() {
        var arr: [Int] = []
        for index in 1 ... (bingoSize * bingoSize) {
            arr.append(index)
        }
        arr = arr.shuffled()
        
        for index in 0 ..< arr.count {
            panels[index / 3][index % 3].number = arr[index]
        }
        
    }
    
    // 수평 빙고 개수 구하기
    func checkHorizontal() -> Int {
        var bingos: Int = 0
        
        for y in 0 ..< bingoSize {
            var count: Int = 0
            
            for x in 0 ..< bingoSize {
                if panels[y][x].isCorrect == true {
                    count += 1
                }
            }
            
            if count == bingoSize {
                bingos += 1
            }
        }
        return bingos
    }
    
    // 수직 빙고 개수 구하기
    func checkVertical() -> Int {
        var bingos: Int = 0
        
        for x in 0 ..< bingoSize {
            var count: Int = 0
            
            for y in 0 ..< bingoSize {
                if panels[y][x].isCorrect == true {
                    count += 1
                }
            }
            
            if count == bingoSize {
                bingos += 1
            }
        }
        return bingos
    }
    
    // 대각 빙고 개수 구하기
    func checkDiagonal() -> Int {
        var bingos: Int = 0
        var count: Int = 0
        
        for y in 0 ..< bingoSize {
            let x: Int = y
            
            if panels[y][x].isCorrect == true {
                count += 1
            }
        }
        if count == bingoSize {
            bingos += 1
        }
        return bingos
    }
    
    // 역 대각 빙고 개수 구하기
    func checkReverseDiagonal() -> Int {
        var bingos: Int = 0
        var count: Int = 0
        
        for y in 0 ..< bingoSize {
            let x: Int = bingoSize - 1 - y
            
            if panels[y][x].isCorrect == true {
                count += 1
            }
        }
        if count == bingoSize {
            bingos += 1
        }
        return bingos
    }
    
    // 빙고 O 또는 X 고치기
    mutating func pressPanel(x: Int ,y: Int) {
        if x < 0 || 3 <= x {
            return
        }
        if y < 0 || 3 <= y {
            return
        }
        
        self.panels[y][x].isCorrect = !panels[y][x].isCorrect
        self.bingoCount = checkDiagonal() + checkReverseDiagonal() + checkVertical() + checkHorizontal()
    }
    
    // 빙고 패널 문자 바꾸기
    mutating func changePanelContents(x: Int, y: Int, input: String) {
        // 이미 패널이 빈 값이 아니라면 바꾸지 않기
        if panels[y][x].content == "" {
            return
        }
        // input으로 받은 내용으로 패널 고치기
        panels[y][x].content = input
    }
    
    func printDetails() {
//        print("=============== Contents ===============")
//        for line in panels {
//            for panel in line {
//                print("\(panel.content)", terminator: "  ")
//            }
//            print()
//        }
        print("=============== Numbers ===============")
        for line in panels {
            for panel in line {
                print("\(panel.number)", terminator: " ")
            }
            print()
        }
        print("\n============ Correctness =============")
        for line in panels {
            for panel in line {
                if panel.isCorrect == true {
                    print("O", terminator: " ")
                } else {
                    print("X", terminator: " ")
                }
            }
            print()
        }
    }
}

var bin: Bingo = Bingo()
bin.pressPanel(x: 2, y: 1)
bin.pressPanel(x: 2, y: 3)
bin.pressPanel(x: 1, y: 1)

bin.printDetails()
