//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Hems Moradiya on 07/04/2022.
//

import UIKit

class ViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clkTask1(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil) /// <- Different storyboard!
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CalculatorViewController") as!
        CalculatorViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    @IBAction func clkTask2(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil) /// <- Different storyboard!
        let Task2Controller = storyBoard.instantiateViewController(withIdentifier: "Task2ViewController") as!
        Task2ViewController
        self.navigationController?.pushViewController(Task2Controller, animated: true)
        
    }
}

