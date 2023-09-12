//
//  ViewModel.swift
//  SuffixHomeWork
//
//  Created by Dmitry Mityunin on 9/10/23.
//

import Foundation
class ViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var suffixArray: [String] = .init()
    @Published var dict: [String: Int] = .init()
    @Published var topDict: [String: Int] = .init()
    
    
    func createArray() {
        suffixArray = .init() // обнуляем
        
        var tmpSuffixArray: [String] = .init()
        for (index, value) in text.enumerated() {
            tmpSuffixArray.append(String(text.suffix(index)))
        }
        
        for suffix in tmpSuffixArray {
            if suffix.count >= 3 {
                suffixArray.append(suffix)
            }
        }
//        let substr = String(text.suffix(3))
//        print(substr)
//        if substr.count == 3 {
//            suffixArray.append(substr)
//        }
//
        
//        let characters = Array(text.lowercased())
//        if characters.count < 3 {
//            return
//
//        }
//
//        for (index, _) in characters.enumerated() {
//            if index <= characters.count - 3 {
//                let tmpArray = Array(arrayLiteral: [characters[index] , characters[index + 1] , characters[index + 2]])
//                let str = tmpArray.reduce ("", +)
//                suffixArray.append(str)
//            } else {
//                break
//            }
//        }
        
        setDict()
    }
    
    func setDict() {
        dict = .init()
        
        for str in suffixArray {
            if dict[str] == nil {
                dict[str] = 1
            } else {
                dict[str] = dict[str]! + 1
            }
        }
        
        setTopDict()
    }
    
    func setTopDict() {
        topDict = .init()
        
        var array = Array(dict.keys.sorted(by: { dict[$0]! > dict[$1]! }).prefix(10))
        
        for key in array {
            topDict[key] = dict[key]
        }
        
       
        
    }
    
    init() {
    }
}
