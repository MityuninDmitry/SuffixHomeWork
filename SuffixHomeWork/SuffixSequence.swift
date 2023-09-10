//
//  SuffixSequence.swift
//  SuffixHomeWork
//
//  Created by Dmitry Mityunin on 9/10/23.
//

import Foundation
struct SuffixSequence: Sequence, IteratorProtocol {
    var text: String
    var charArray: [Character]
    var currentCharIndex: Int? = 0
    var charCount: Int?
    var dict: [String: Int]?
    
    mutating func next() -> Int? {
        charArray = text.map({ ch in
            return ch
        })
        
        if let safeIndex = currentCharIndex {
            
            if safeIndex < charArray.count - 3 {
                currentCharIndex! += 1
            } else {
                currentCharIndex = nil
            }
        } else {
            currentCharIndex = nil
        }
        
        return currentCharIndex
        
        
    }
    
    
}
