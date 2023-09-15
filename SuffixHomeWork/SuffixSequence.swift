//
//  SuffixSequence.swift
//  SuffixHomeWork
//
//  Created by Dmitry Mityunin on 9/10/23.
//

import Foundation
struct SuffixSequence: Sequence, IteratorProtocol {
    var text: String // текст для поиска суффиксов
    
    mutating func next() -> String? { // выдаем суффикс
        var suffix: String?
        
        if text.count < 3 { // если длина суффикса меньше 3, то все
            return nil
        } else {
            suffix = String(text.suffix(3))
            text = String(text.prefix(text.count - 1)) // уменьшаем длину текста на 1. чтобы забрать в след итерации след суффикс 
        }
        
        return suffix
    }
}
