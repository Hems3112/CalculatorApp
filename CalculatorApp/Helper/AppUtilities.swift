//
//  AppUtilities.swift
//  CalculatorApp
//
//  Created by Hems Moradiya on 11/04/2022.
//

import Foundation
import UIKit


struct ColorPicker {
    static let Button_hightLightColor = UIColor(red: 114.0/255.0, green: 114.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    static let Button_NormalColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    
}


class AppUtilities{
    
    class var sharedInstance : AppUtilities {
        struct Singleton {
            static let instance = AppUtilities()
        }
        
        return Singleton.instance
    }
    func zoomInOutAnimation(ZoomnVW : UIButton){
        
        ZoomnVW.backgroundColor = ColorPicker.Button_hightLightColor
        UIView.animate(withDuration: 0.3 / 1.5, animations: {
            ZoomnVW.transform =
                    CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
            }) { finished in
                    UIView.animate(withDuration: 0.3 / 2, animations: {
                        ZoomnVW.transform = CGAffineTransform.identity
                        ZoomnVW.backgroundColor = ColorPicker.Button_NormalColor
                    })
                }
            
    }
    
}
class CustomButton: UIButton {
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            
        }
    }
    
}

extension Double {
    var clean: String {
           return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    func StringValue() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        let newvalue = formatter.string(from: NSNumber(value: self)) ?? ""
        return newvalue
    }
}
