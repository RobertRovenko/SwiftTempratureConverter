//
//  ViewController.swift
//  TemperaturConverter
//
//  Created by Robert Falkbäck on 2023-09-06.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var lblResult: UILabel!
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    var celsiusValues = (-100...100).map{$0}
    var fahrenheinValues = (-148...212).map{$0}
    
    let SAVED_CELCIUS = "savedCelcius"
    let SAVED_FAHRENHEIT = "savedFahrenheit"
    
    let converter = Converter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPickerView.selectRow(getSavedRow(key: SAVED_CELCIUS), inComponent: 0, animated: true)
        myPickerView.selectRow(getSavedRow(key: SAVED_FAHRENHEIT), inComponent: 1, animated: true)
        
        pickerView(myPickerView, didSelectRow: getSavedRow(key: SAVED_CELCIUS), inComponent: 0)
        pickerView(myPickerView, didSelectRow: getSavedRow(key: SAVED_FAHRENHEIT), inComponent: 1)
        
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return celsiusValues.count
        }else{
            return fahrenheinValues.count
        }
        
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            
            return "\(String(celsiusValues[row])) ℃"
            
        }else{
            
            return "\(String(fahrenheinValues[row])) ℉"
        }
        
      
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        saveToDefault(row: row, key: component == 0 ? SAVED_CELCIUS : SAVED_FAHRENHEIT)
        
        var result = 0
        
        
        if component == 0{
            result = converter.toFahrenheit(celcius: celsiusValues[row])
        }else{
            result = converter.toCelcius(fahrenheit: fahrenheinValues[row])
        }
        
        
        lblResult.text = String(result) + "\(component == 0 ? " ℉" : " ℃")"
        
    print("user selected: \(row)")
    }
   
    func getSavedRow(key: String) -> Int{
        
    
        let defaults = UserDefaults.standard
        
        let savedRow = defaults.object(forKey: "lastValue") as? Int
        
        if let savedRow = savedRow {
            return savedRow
        }else{
            return 100
        }
        
    }
    
    func saveToDefault(row: Int, key: String){
        
        let defaults = UserDefaults.standard
        
        defaults.set(row, forKey: "lastValue")
        
    }

}

