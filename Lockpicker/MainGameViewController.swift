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
    
    @IBOutlet weak var digitPickerView: UIPickerView!
    
    @IBAction func guessButtonPress(_ sender: UIButton) {
        
        clearHints()
        
        var userInputArray = Array(repeating: 0, count: userDefinedDigitsCount)
        
        for i in 0..<userDefinedDigitsCount {
         userInputArray[i] = digitPickerView.selectedRow(inComponent: i) % userDefinedMaxRange
        }
        
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
        return userDefinedDigitsCount
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
    
    func setupPicker() {
        self.digitPickerView.delegate = self
        
        for i in 0..<userDefinedDigitsCount {
        digitPickerView.selectRow(pickerDataSize/2, inComponent: i, animated: false)    //  Setting picker position to the middle
            }
    }
    
    func setupArrays() {
        userDefinedRangeArray = try! generateRangeArray(from: userDefinedMaxRange)
        generatedTargetArray = try! generateDigitsArray(from: userDefinedRangeArray, digits_amount: userDefinedDigitsCount)
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
