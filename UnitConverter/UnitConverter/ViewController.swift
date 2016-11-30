//
//  ViewController.swift
//  UnitConverter
//
//  Created by prabhjot singh on 11/11/16.
//  Copyright © 2016 Prabhjot Singh. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var btnTypeUnit: UIButton!
    @IBOutlet weak var txtFirstUnit: UITextField!
    @IBOutlet weak var txtSecondUnit: UITextField!
    @IBOutlet weak var firstPicker: UIPickerView!
    @IBOutlet weak var secondPicker: UIPickerView!
    
    
    let dicOfUnits: [String: [PSUnitCovertible]] = ["Weight": Array<Weight>([Weight.grams(.kilo), Weight.grams(.milli), Weight.grams(.nano), Weight.grams(.micro), Weight.grams(.none), Weight.grams(.mega), Weight.grams(.centi), Weight.grams(.giga), Weight.grams(.terra), Weight.ounces, Weight.imperialTons, Weight.pounds, Weight.stones, Weight.usTons]),
                                     "Length": Array<Length>([Length.feet, Length.inches, Length.miles, Length.yards, Length.meters(.centi), Length.meters(.kilo), Length.meters(.milli), Length.meters(.nano), Length.meters(.none)]),
                                     "Temperature": Array<Temperature>([Temperature.celsius, Temperature.fahrenheit, Temperature.kelvin]),
                                     "Time": Array<Time>([Time.day, Time.hour, Time.minute, Time.month, Time.week, Time.year, Time.seconds(.milli), Time.seconds(.none), Time.seconds(.micro)]),
                                     "Frequency": Array<Frequency>([Frequency.hertz(.giga), Frequency.hertz(.none), Frequency.hertz(.kilo), Frequency.hertz(.mega)]),
                                     "DigitalStorage": Array<DigitalStorage>([DigitalStorage.bit, DigitalStorage.byte, DigitalStorage.gigaByte, DigitalStorage.kilobyte, DigitalStorage.megabyte, DigitalStorage.terabyte])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initialInitialization()
    }
    
    func initialInitialization() {
        firstPicker.selectRow(0, inComponent: 0, animated: false)
        secondPicker.selectRow(0, inComponent: 0, animated: false)
        txtFirstUnit.text = "1"
        txtSecondUnit.text = "1"
    }
    
    var keyIndex = 0
    @IBAction func updatePickers() {
        
        let arrayOfKeys: [String] = Array(dicOfUnits.keys)
        keyIndex += 1
        if keyIndex >= arrayOfKeys.count {
            keyIndex = 0
        }
        btnTypeUnit.setTitle(arrayOfKeys[keyIndex], for: .normal)
        firstPicker.reloadAllComponents()
        secondPicker.reloadAllComponents()
        self.initialInitialization()
    }

    func updateValues(selectedUnitIndex: Int) {

        let text = selectedUnitIndex == 1 ? (txtFirstUnit.text! == " " ? "0": txtFirstUnit.text!) : (txtSecondUnit.text! == " " ? "0": txtSecondUnit.text!)
        let textValue = Double(text)
        
        if (textValue == nil) {return}
        
        var result: Double?
        
        let selctedRow1 = firstPicker!.selectedRow(inComponent: 0)
        let selctedRow2 = secondPicker!.selectedRow(inComponent: 0)
        
        switch btnTypeUnit.currentTitle! {
        case "Weight":
            let firstUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Weight>)[selctedRow1]
            let secondUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Weight>)[selctedRow2]
            let weight = Unit(value:textValue!, unit:selectedUnitIndex == 1 ? firstUnitConvertible: secondUnitConvertible)
            let resultUnit = weight.convert(to: selectedUnitIndex == 2 ? firstUnitConvertible: secondUnitConvertible)
            result = resultUnit.value
        case "Length":
            let firstUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Length>)[selctedRow1]
            let secondUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Length>)[selctedRow2]
            let length = Unit(value:textValue!, unit:selectedUnitIndex == 1 ? firstUnitConvertible: secondUnitConvertible)
            let resultUnit = length.convert(to: selectedUnitIndex == 2 ? firstUnitConvertible: secondUnitConvertible)
            result = resultUnit.value
        case "Temperature":
            let firstUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Temperature>)[selctedRow1]
            let secondUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Temperature>)[selctedRow2]
            let temp = Unit(value:textValue!, unit:selectedUnitIndex == 1 ? firstUnitConvertible: secondUnitConvertible)
            let resultUnit = temp.convert(to: selectedUnitIndex == 2 ? firstUnitConvertible: secondUnitConvertible)
            result = resultUnit.value
        case "DigitalStorage":
            let firstUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<DigitalStorage>)[selctedRow1]
            let secondUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<DigitalStorage>)[selctedRow2]
            let temp = Unit(value:textValue!, unit:selectedUnitIndex == 1 ? firstUnitConvertible: secondUnitConvertible)
            let resultUnit = temp.convert(to: selectedUnitIndex == 2 ? firstUnitConvertible: secondUnitConvertible)
            result = resultUnit.value
        case "Frequency":
            let firstUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Frequency>)[selctedRow1]
            let secondUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Frequency>)[selctedRow2]
            let temp = Unit(value:textValue!, unit:selectedUnitIndex == 1 ? firstUnitConvertible: secondUnitConvertible)
            let resultUnit = temp.convert(to: selectedUnitIndex == 2 ? firstUnitConvertible: secondUnitConvertible)
            result = resultUnit.value
        case "Time":
            let firstUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Time>)[selctedRow1]
            let secondUnitConvertible = (self.dicOfUnits[btnTypeUnit.currentTitle!] as! Array<Time>)[selctedRow2]
            let temp = Unit(value:textValue!, unit:selectedUnitIndex == 1 ? firstUnitConvertible: secondUnitConvertible)
            let resultUnit = temp.convert(to: selectedUnitIndex == 2 ? firstUnitConvertible: secondUnitConvertible)
            result = resultUnit.value
            
        default:
            break
        }
        
        if selectedUnitIndex == 1 {
            txtSecondUnit.text = "\(result!)"
        } else {
            txtFirstUnit.text = "\(result!)"
        }
    }
    
    func getUnit<T: PSUnitCovertible>(object: T) -> Unit<T> {
        return Unit(value: 10, unit: object)
    }

}

//MARK: - Picker Delegates

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dicOfUnits[btnTypeUnit.currentTitle!]!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let name = self.dicOfUnits[btnTypeUnit.currentTitle!]?[row].name()
        return name?.replacingOccurrences(of: "UnitConverter.MatricPrefix.", with: "")

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateValues(selectedUnitIndex: 1)
    }
}
//
extension ViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (string == " ") {return false}
        
        let newLength:Int = textField.text!.utf16.count + string.utf16.count - range.length
        
        return newLength <= 20
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != nil && textField.text != "" {
            if textField == txtFirstUnit {
                self.updateValues(selectedUnitIndex: 1)
            } else {
                self.updateValues(selectedUnitIndex: 2)
            }
        }
        return true
    }
}
