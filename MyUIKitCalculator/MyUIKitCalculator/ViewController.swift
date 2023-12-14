//
//  ViewController.swift
//  MyUIKitCalculator
//
//  Created by 이선준 on 12/14/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var screenLabel: UILabel!
    
    var myCalc: Calculator = Calculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        screenLabel.text = myCalc.screen
    }

    @IBAction func clearButton(_ sender: UIButton) {
        if sender.tag == 0 {
            myCalc.clear()
        } else if sender.tag == 1 {
            myCalc.clearEverything()
        } else {
            return
        }
        screenLabel.text = myCalc.screen
    }
    
    @IBAction func numberButton(_ sender: UIButton) {
        myCalc.pressNumber(tag: sender.tag)
        screenLabel.text = myCalc.screen
    }
    
    @IBAction func operButton(_ sender: UIButton) {
        if sender.tag == 0 {
            myCalc.pressEqual()
        } else if 0 < sender.tag || sender.tag < 5 {
            myCalc.pressOperator(tag: sender.tag)
        } else {
            return
        }
        
        screenLabel.text = myCalc.screen
    }
    
}

