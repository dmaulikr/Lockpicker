//
//  Logic.swift
//  Lockpicker
//
//  Created by Alex Zanevskiy on 08/08/2017.
//  Copyright © 2017 Alex Zanevskiy. All rights reserved.
//

import Foundation

enum RandomNumbersError : Swift.Error {
    case rangeLessThanCount
    case countIsNotPositive
    case inputGreaterThanRange
    case containsDuplicates
}
    
    extension RandomNumbersError: LocalizedError {
        public var errorDescription: String? {
            switch self {
                case .rangeLessThanCount: return NSLocalizedString("Guessing range is too small!", comment: "")
                case .countIsNotPositive: return NSLocalizedString("Range can't be negative number!", comment: "")
                case .inputGreaterThanRange: return NSLocalizedString("Player input is larger than target", comment: "")
                case .containsDuplicates: return NSLocalizedString("You've entered duplicate numbers!", comment: "")
            }
        }
    }


func generateRangeArray(from range: Int = 9) throws -> Array<Int> {
    
    if range <= 0 {
        throw RandomNumbersError.countIsNotPositive
    }
    
    var rangeArray = Array(0..<range)
    
    for possibleDigits in 0..<range {
        rangeArray[possibleDigits] = possibleDigits
    }
    return rangeArray
}


func generateDigitsArray(from rangeArray: [Int], digits_amount: Int = 4) throws -> Array<Int> {
    
    if rangeArray.count < digits_amount {
        throw RandomNumbersError.rangeLessThanCount
    }
    
    var rangeArray = rangeArray
    var digitsArray = Array(0..<digits_amount)
    
    for i in 0..<digits_amount {
        let index = Int(arc4random_uniform(UInt32(rangeArray.count)))
        let digit = rangeArray.remove(at: Int(index))
        digitsArray[i] = digit
    }
    return digitsArray
}


func calculateAnswer(playerInput: Array<Int>, targetArray: Array<Int>) throws -> Any {
    
    var playerInputArray = playerInput
    var digitsArray = targetArray
    var correctCount = 0
    var containingCount = 0
    
    let duplicates = Array(Set(playerInput.filter({ (i: Int) in playerInput.filter({ $0 == i }).count > 1})))
    
    if !duplicates.isEmpty {
        throw RandomNumbersError.containsDuplicates
    }
    
    if playerInput.count > targetArray.count {
        throw RandomNumbersError.inputGreaterThanRange
    }
    
    for (index, playerInputNumber) in playerInputArray.enumerated() {
        
        if playerInputArray[index] == digitsArray[index]{
            correctCount += 1
        } else if digitsArray.contains(playerInputArray[index]) {
            containingCount += 1
        }
    }
    
    if correctCount == digitsArray.count {
        return "You won"
    }
    
    return (correctCount, containingCount)
}
