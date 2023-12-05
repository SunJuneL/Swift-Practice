//
//  ViewController.swift
//  MyCalculator
//
//  Created by 이선준 on 12/4/23.
//

import UIKit

class ViewController: UIViewController {
    
    // 변수 초기화 부분
    @IBOutlet weak var numberLabel: UILabel!
    var myCalc: Calculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numberLabel.text = "\(myCalc.currentNumber)"
    }

    // 버튼 함수
    @IBAction func numberButtons( sender: UIButton) {
        myCalc.getNumberFromScreen(senderTag: sender.tag)
        numberLabel.text = "\(myCalc.currentNumber)"
    }
    
    @IBAction func resetNumber( sender: UIButton) {
        myCalc.currentNumber = 0
        myCalc.operatorType = -1
        numberLabel.text = "\(myCalc.currentNumber)"
    }
    
    @IBAction func operatorButtons( sender: UIButton) {
        myCalc.calculate()
        if sender.tag != 0 {
            myCalc.setOperator(senderTag: sender.tag)
        }
        numberLabel.text = "\(myCalc.previousNumber)"
    }
}

