//
//  ViewController.swift
//  WorldTrotter
//
//  Created by ladmin on 7/12/22.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    let layer = CAGradientLayer()
    let currentLocale = Locale.current
    
    @IBOutlet var celciusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2

        if let fahrenheitString = textField.text, let tempF = nf.number(from: fahrenheitString) {
            let measurementF = Measurement<UnitTemperature>(value: tempF.doubleValue, unit: .fahrenheit)
            celciusLabel.text = nf.string(from: NSNumber(value: (measurementF.converted(to: .celsius).value)))! + "\u{2103}"
        } else {
            celciusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing: Self.self))
        layer.colors = [
            #colorLiteral(red: 1, green: 0.2440383272, blue: 0.1067086709, alpha: 0.2213369205).cgColor,
            #colorLiteral(red: 0.1137254902, green: 0.4549019608, blue: 0.9921568627, alpha: 1).cgColor,
            #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        ]
     
        layer.shouldRasterize = true
        layer.locations = [0.28, 0.50,  1.0]
        layer.frame = self.view.bounds
        self.view.layer.insertSublayer(layer, at: 0)
    }
    
    override func viewDidLayoutSubviews() {
        layer.frame = view.bounds
        super.viewDidLayoutSubviews()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if let currentText = textField.text {
            let range = string.rangeOfCharacter(from: NSCharacterSet.letters)
            let newText = currentText + string
            if(currentLocale.decimalSeparator != nil && currentText.contains(currentLocale.decimalSeparator!) && string == currentLocale.decimalSeparator!) {
                return false
            } else if range != nil {
                return false
            } else if newText.count > 6 {
                return false
            }
        }
        return true
    }
}
