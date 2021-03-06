//
//  CalculatorViewController.swift
//  CalculatorApp
//
//  Created by Hems Moradiya on 19/04/2022.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var holder: UIView!
    
    private var resultLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica-Bold", size: 60)
        return label
    }()
    
    private var OldValueLabel : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .lightGray
        label.textAlignment = .right
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Helvetica-Bold", size: 38)
        return label
    }()
    
    var buttonSize : CGFloat = 0
    private var FontSize : CGFloat = 32.0
    
    var FirstNumber = 0.0
    var resultNumber = 0.0
    var CurrentOparatiuons : Operations?
    var arrInput : [String] = []
    
    enum Operations {
        case add, subtract , multiply , division ,equal
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        SetUpNumberPad()
        FontSize = self.view.bounds.size.height * 0.045
    }

    private func SetUpNumberPad(){
        buttonSize = self.view.bounds.size.width / 4
        
        //Button Zero (0)
        let zeroButoon : CustomButton = CustomButton(frame: .zero)
        zeroButoon.frame = CGRect(x: 0, y: holder.frame.size.height - buttonSize, width: buttonSize * 2 - 5, height: buttonSize)
        zeroButoon.setTitle("0", for: .normal)
        zeroButoon.setTitleColor(.white, for: .normal)
        zeroButoon.backgroundColor = ColorPicker.Button_NormalColor
        //zeroButoon.tag = 1
        self.ApplyDefaultRoundCorner_Border(btn: zeroButoon)
        zeroButoon.titleLabel?.font = UIFont.systemFont(ofSize: FontSize)
        zeroButoon.addTarget(self, action: #selector(ZeroPressed), for: .touchUpInside)
        holder.addSubview(zeroButoon)
        
        let DotButoon : CustomButton = CustomButton(frame: .zero)
        DotButoon.frame = CGRect(x: zeroButoon.bounds.size.width + 5, y: holder.frame.size.height - buttonSize, width: buttonSize, height: buttonSize)
        DotButoon.setTitle(".", for: .normal)
        DotButoon.setTitleColor(.white, for: .normal)
        DotButoon.backgroundColor = ColorPicker.Button_NormalColor
        //zeroButoon.tag = 1
        self.ApplyDefaultRoundCorner_Border(btn: DotButoon)
        DotButoon.titleLabel?.font = UIFont.systemFont(ofSize: FontSize + 10)
        DotButoon.addTarget(self, action: #selector(DotPressed), for: .touchUpInside)
        holder.addSubview(DotButoon)
        
        
        //Button 0 to 9
        for x in 0..<3{
            let btn1 = CreateNumberButton(str: "\(x+1)")
            btn1.frame.origin.x = buttonSize * CGFloat(x)
            btn1.frame.origin.y = holder.frame.size.height - (buttonSize * 2) - 10
            btn1.setTitleColor(.white, for: .normal)
            btn1.tag = x + 2
            btn1.addTarget(self, action: #selector(NumberPressed(_:)), for: .touchUpInside)
            holder.addSubview(btn1)
        }
        for x in 0..<3{
            let btn2 = CreateNumberButton(str: "\(x+4)")
            btn2.frame.origin.x = buttonSize * CGFloat(x)
            btn2.frame.origin.y = holder.frame.size.height - (buttonSize * 3) - 15
            btn2.setTitleColor(.white, for: .normal)
            
            btn2.tag = x + 5
            btn2.addTarget(self, action: #selector(NumberPressed(_:)), for: .touchUpInside)
            holder.addSubview(btn2)
        }
        for x in 0..<3{
            let btn3 = CreateNumberButton(str: "\(x+7)")
            btn3.frame.origin.x = buttonSize * CGFloat(x)
            btn3.frame.origin.y = holder.frame.size.height - (buttonSize * 4) - 20
            btn3.setTitleColor(.white, for: .normal)
            btn3.tag = x + 8
            btn3.addTarget(self, action: #selector(NumberPressed(_:)), for: .touchUpInside)
            holder.addSubview(btn3)
        }
        //Button CS (Clear Display)
        let ClearButoon : CustomButton = CustomButton(frame: .zero)
        ClearButoon.frame = CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 5) - 25, width: holder.frame.size.width - buttonSize, height: buttonSize - 10)
        ClearButoon.setTitle("AC", for: .normal)
        ClearButoon.setTitleColor(.white, for: .normal)
        ClearButoon.backgroundColor = UIColor.orange
        ClearButoon.titleLabel?.font = UIFont.systemFont(ofSize: FontSize)
        self.ApplyDefaultRoundCorner_Border(btn: ClearButoon)
        holder.addSubview(ClearButoon)
        
        ClearButoon.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        //[ + - * / =] Button Create
        let operation = ["=","+","-","*","/"]
        for x in 0..<5{
            let operationbtn = CreateNumberButton(str: operation[x])
            operationbtn.frame.origin.x = buttonSize * CGFloat(3)
            operationbtn.frame.origin.y = holder.frame.size.height - (buttonSize * CGFloat(x+1))
            if x != 0 {
                operationbtn.frame.origin.y -= CGFloat(x*5)
            }
            ClearButoon.titleLabel?.font = UIFont.systemFont(ofSize: FontSize + 5)
            operationbtn.setTitleColor(.white, for: .normal)
            operationbtn.backgroundColor = UIColor.orange
            operationbtn.tag = x + 1
            operationbtn.addTarget(self, action: #selector(OperationPressed(_:)), for: .touchUpInside)
            holder.addSubview(operationbtn)
        }
        
        resultLabel.frame = CGRect(x: 0, y: ClearButoon.frame.origin.y - 110, width: holder.frame.size.width - 20, height: 120)
        holder.addSubview(resultLabel)
        
        OldValueLabel.frame = CGRect(x: 0, y: resultLabel.frame.origin.y - 110, width: holder.frame.size.width - 20, height: 120)
        OldValueLabel.font = UIFont(name: "Helvetica-Bold", size: FontSize)
        resultLabel.font = UIFont(name: "Helvetica-Bold", size: FontSize * 1.25)
        holder.addSubview(OldValueLabel)
        
    }

    //MARK: -  Button Actions
    @objc func clearResult(){
        resultLabel.text = "0"
        OldValueLabel.text = ""
        CurrentOparatiuons = nil
        FirstNumber = 0.0
        arrInput = []
    }
    
    
    @objc func ZeroPressed(){
        if resultLabel.text != "0"{
            if let value = resultLabel.text{
                resultLabel.text = "\(value)\(0)"
            }
        }
    }
    
    @objc func DotPressed(){
        if !(resultLabel.text?.contains("."))!{
            if let value = resultLabel.text{
                resultLabel.text = "\(value).\(0)"
            }
        }
    }
    
    
    @objc func NumberPressed(_ sender : UIButton){
        if CurrentOparatiuons != nil || CurrentOparatiuons == .equal{
            //let perform calculation from array value
        }
       // performCalculation()
        let tag = sender.tag - 1
        if resultLabel.text == "0"{
            resultLabel.text = "\(tag)"
        }else if let value = resultLabel.text{
            resultLabel.text = "\(value)\(tag)"
        }
       AppUtilities.sharedInstance.zoomInOutAnimation(ZoomnVW: sender)
    }
    
    @IBAction func ClkClose(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func performCalculation(){
       // let StringToDelete = ["+","-","*","/","="]
        if let operation = CurrentOparatiuons{
            var secondNumber = 0.0
            if let text = resultLabel.text , let value = Double(text){
                secondNumber = value
            }
            switch operation {
            case .add:
                let result = FirstNumber + secondNumber
                resultLabel.text = "\(result.StringValue())"
                break
            case .subtract:
                let result = FirstNumber - secondNumber
                resultLabel.text = "\(result.StringValue())"
                break
            case .multiply:
                let result = FirstNumber * secondNumber
                resultLabel.text = "\(result.StringValue())"
                break
            case .division:
                let result = FirstNumber / secondNumber
                resultLabel.text = "\(result.StringValue())"
                break
            case .equal:
                break
            }
        }
        resultNumber = Double(resultLabel.text!) ?? 0.0
        print(FirstNumber)
        print(resultNumber)
       
    }
    
    
    @objc func OperationPressed(_ sender : UIButton){
        
        let tag = sender.tag
        if let text = resultLabel.text,let value = Double(text) , FirstNumber == 0.0{
            FirstNumber = value
            resultLabel.text = "0"
            arrInput.insert("\(FirstNumber.clean)", at: 0)
            //arrInput.append("\(FirstNumber.clean)")
        }else{
            arrInput.insert("\(resultLabel.text!)", at: arrInput.count - 1)
            //arrInput.append("\(resultLabel.text!)")
        }
        if tag == 1 {
            CurrentOparatiuons = .equal
        }else if tag == 2{
            CurrentOparatiuons = .add
            arrInput.append("+")
            
        }else if tag == 3{
            CurrentOparatiuons = .subtract
            arrInput.append("-")
           
        }else if tag == 4{
            CurrentOparatiuons = .multiply
            arrInput.append("*")
            
        }else if tag == 5{
            CurrentOparatiuons = .division
            arrInput.append("/")
           
        }
        performCalculation()
        OldValueLabel.text = "\(arrInput.joined(separator: ", "))"
        resultLabel.text = ""
    }
    
    
    
    func ApplyDefaultRoundCorner_Border(btn : CustomButton){
        
        btn.cornerRadius = btn.bounds.size.height / 2
        btn.clipsToBounds = true
    }
    
    private func CreateNumberButton(str: String) -> UIButton{
        let button : CustomButton = CustomButton(frame: .zero)
        button.frame.size = CGSize(width: buttonSize, height: buttonSize)
        button.titleLabel?.font = UIFont.systemFont(ofSize: FontSize)
        button.setTitle(str, for: .normal)
        button.backgroundColor = ColorPicker.Button_NormalColor
        self.ApplyDefaultRoundCorner_Border(btn: button)
        return button
        
    }

}
