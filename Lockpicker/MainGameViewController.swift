//
//  MainGameViewController.swift
//  Lockpicker
//
//  Created by Alex Zanevskiy on 08/08/2017.
//  Copyright © 2017 Alex Zanevskiy. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //  MARK: - Constants and Variables
    
    let pickerDataSize = 100_000                // Constant for nearly infinite picker
    
    var userDefinedDigitsCount = 4
    var userDefinedMaxRange = 10
    var userDefinedRangeArray = [0]
    var generatedTargetArray = [0]
    

    //  MARK: - IBOutlets
    
    @IBOutlet weak var containingCountView: UIView!
    @IBOutlet weak var correctCountView: UIView!

    @IBOutlet weak var containingCountLabel: UILabel!
    @IBOutlet weak var correctCountLabel: UILabel!
    
    @IBOutlet weak var digitPicker1: UIPickerView!
    @IBOutlet weak var digitPicker2: UIPickerView!
    @IBOutlet weak var digitPicker3: UIPickerView!
    @IBOutlet weak var digitPicker4: UIPickerView!
    
    @IBAction func guessButtonPress(_ sender: UIButton) {
        
        clearHints()
        
        var userInputArray = [0,0,0,0]
        
        userInputArray[0] = digitPicker1.selectedRow(inComponent: 0) % userDefinedMaxRange
        userInputArray[1] = digitPicker2.selectedRow(inComponent: 0) % userDefinedMaxRange
        userInputArray[2] = digitPicker3.selectedRow(inComponent: 0) % userDefinedMaxRange
        userInputArray[3] = digitPicker4.selectedRow(inComponent: 0) % userDefinedMaxRange
        
        do {
            let guess = try calculateAnswer(playerInput: userInputArray, targetArray: generatedTargetArray)
            
            if guess.0 > 0 {
                correctCountLabel.text = String(guess.0)
                correctCountView.isHidden = false
            }
            
            if guess.1 > 0 {
                containingCountLabel.text = String(guess.1)
                containingCountView.isHidden = false
            }
            
            if guess.0 == userDefinedDigitsCount {
                showAlert(alertTitle: "Congratulation!", alertDescription: "You won!")
            }
            
        } catch let error as RandomNumbersError {
            showAlert(alertTitle: "Error!", alertDescription: error.errorDescription)
        } catch {
            showAlert(alertTitle: "Error", alertDescription: "General Failure")
        }
    }
    
    @IBAction func startNewGameButtonPress(_ sender: UIButton) {
        startNewGame()
    }
    
    //  MARK: - Picker functions
    
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
    
    
    //  MARK: - Main funcitons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func clearHints() {
        containingCountView.isHidden = true
        correctCountView.isHidden = true
    }
    
    func startNewGame() {
        clearHints()
        setupPicker()
        setupArrays()
        showAlert(alertTitle: "New Game", alertDescription: "New keylock code is generated")
    }
    
    func showAlert(alertTitle: String?, alertDescription: String?) {
        let title = alertTitle
        let error = alertDescription
        let alert = UIAlertController(title: alertTitle, message: error, preferredStyle: .alert)
        let action  = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}
