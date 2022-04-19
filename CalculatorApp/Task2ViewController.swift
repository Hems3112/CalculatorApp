//
//  Task2ViewController.swift
//  CalculatorApp
//
//  Created by Hems Moradiya on 19/04/2022.
//

import UIKit

class Task2ViewController: UIViewController {

    
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var LblValueEnter: UILabel!
    
    @IBOutlet weak var lblMean: UILabel!
    @IBOutlet weak var LblMedian: UILabel!
    
    private var ArrValues : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func ClkClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ClkAddSet(_ sender: UIButton) {
        if let text = txtNumber.text , let value = Int(text){
            ArrValues.append(value)
            txtNumber.text = ""
            LblValueEnter.text = "\(ArrValues.limit(ArrValues.count))"
        }
        
    }
    
    func calculateMedian(array: [Int]) -> Float {
        let sorted = array.sorted()
        if sorted.count % 2 == 0 {
            return Float((sorted[(sorted.count / 2)] + sorted[(sorted.count / 2) - 1])) / 2
        } else {
            return Float(sorted[(sorted.count - 1) / 2])
        }
    }
    
    @IBAction func Clkmedian(_ sender: UIButton) {
        
        let m2 = self.calculateMedian(array: ArrValues)
        LblMedian.text = "Median Value:"
        LblMedian.attributedText =
        NSMutableAttributedString().normal("Median Value").bold("\(m2)")
    }
    
    @IBAction func ClkMean(_ sender: UIButton) {
        
        let Avarage = ArrValues.sum() / ArrValues.count
        lblMean.text = "Mean Value:"
        lblMean.attributedText =
        NSMutableAttributedString().normal("Mean Value").bold("\(Avarage)")
        
    }

}
