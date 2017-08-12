//
//  MainGameViewController.swift
//  Lockpicker
//
//  Created by Alex Zanevskiy on 08/08/2017.
//  Copyright © 2017 Alex Zanevskiy. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    //    Mark: - IBOutlets
    
    @IBOutlet weak var correctNumberView: UIView!
    @IBOutlet weak var correctDigitPosition: UIView!
    
    @IBOutlet weak var digitPicker1: UIPickerView!
    @IBOutlet weak var digitPicker2: UIPickerView!
    @IBOutlet weak var digitPicker3: UIPickerView!
    @IBOutlet weak var digitPicker4: UIPickerView!
    
    @IBAction func guessButton(_ sender: UIButton) {
        var userInputArray = [0,0,0,0]
        
        userInputArray[0] = digitPicker1.selectedRow(inComponent: 0) % userDefinedMaxRange
        userInputArray[1] = digitPicker2.selectedRow(inComponent: 0) % userDefinedMaxRange
        userInputArray[2] = digitPicker3.selectedRow(inComponent: 0) % userDefinedMaxRange
        userInputArray[3] = digitPicker4.selectedRow(inComponent: 0) % userDefinedMaxRange
        
        do {
            let guess = try calculateAnswer(playerInput: userInputArray, targetArray: generatedTargetArray)
            print(guess)
        } catch {
            print("error")
        }
    }
    
    
    
    let pickerDataSize = 100_000                // Constant for nearly infinite picker
    
    var userDefinedDigitsCount = 4
    var userDefinedMaxRange = 10
    var userDefinedRangeArray = [0]
    var generatedTargetArray = [0]
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row % userDefinedMaxRange)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let valueSelected = (row % userDefinedMaxRange)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        setupPicker()
        setupArrays()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPicker() {                        //  Should make picker generator func to provide MOAR PICKERS
        
        self.digitPicker1.delegate = self
        self.digitPicker2.delegate = self
        self.digitPicker3.delegate = self
        self.digitPicker4.delegate = self
        
        self.digitPicker1.dataSource = self
        self.digitPicker2.dataSource = self
        self.digitPicker3.dataSource = self
        self.digitPicker4.dataSource = self
        
//  Setting picker position to the middle
        
        digitPicker1.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
        digitPicker2.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
        digitPicker3.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
        digitPicker4.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
    }
    
    func setupArrays() {
        userDefinedRangeArray = try! generateRangeArray()
        generatedTargetArray = try! generateDigitsArray(from: generateRangeArray())
    }
    
}
