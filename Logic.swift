//
//  Logic.swift
//  Lockpicker
//
//  Created by Alex Zanevskiy on 08/08/2017.
//  Copyright © 2017 Alex Zanevskiy. All rights reserved.
//

func generateRangeArray(range: Int) -> Array<Int> {
    
    var rangeArray = Array(0..<range)
    for possibleDigits in 0..<range {
        rangeArray[possibleDigits] = possibleDigits
    }
    return rangeArray
}


func generateDigitsArray(rangeArray: Array<Int>, digits_amount: Int) -> Array<Int> {
    
    var rangeArray = rangeArray
    var digitsArray = Array(0..<digits_amount)
    
    for i in 0..<digits_amount {
        let index = Int(arc4random_uniform(UInt32(rangeArray.count)))
        let digit = rangeArray.remove(at: Int(index))
        digitsArray[i] = digit
    }
    print(digitsArray)
    return digitsArray
}


func calculateBullsAndCows(playerInput: Array<Int>, targetArray: Array<Int>) -> (bullsCount: Int, cowsCount: Int) {
    
    var playerInputArray = playerInput
    var digitsArray = targetArray
    var bullsCount = 0
    var cowsCount = 0
    
    for (index, playerInputNumber) in playerInputArray.enumerated() {
        
        if digitsArray.contains(playerInputArray[index]){
            cowsCount += 1
        } else if playerInputArray[index] == digitsArray[index] {
            bullsCount += 1
        }
    }
    return (bullsCount, cowsCount)
}
