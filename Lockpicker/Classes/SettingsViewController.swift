//
//  SettingsViewController.swift
//  Lockpicker
//
//  Created by Alex Zanevskiy on 15/08/2017.
//  Copyright © 2017 Alex Zanevskiy. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func changeSettings(maxRange: Int, pickerCount: Int)
}

class SettingsViewController: UIViewController {
    
    var pickerCount: Int = 4
    var maxRange: Int = 10
    
    var delegate : SettingsDelegate?
   
    @IBAction func saveButtonPress(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
        delegate?.changeSettings(maxRange: maxRange, pickerCount: pickerCount)
    }
    
    @IBAction func cancelButtonPress(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBOutlet weak var digitValueLabel: UILabel!
    @IBOutlet weak var pickerCountSegmentedControl: UISegmentedControl!
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        switch pickerCountSegmentedControl.selectedSegmentIndex
            {
            case 0:
                pickerCount = 3;
            case 1:
                pickerCount = 4;
            case 2:
                pickerCount = 5;
            default: pickerCount = 4
            }
        }
    
    @IBAction func digitsStepperValueChanged(_ sender: UIStepper) {
        digitValueLabel.text = Int(sender.value).description
        maxRange = Int(digitValueLabel.text!)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


