//
//  ViewModel.swift
//  SuffixHomeWork
//
//  Created by Dmitry Mityunin on 9/10/23.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    @Published var text: String = "" {
        didSet {
            createArray()
        }
    }
    @Published var suffixArray: [String] = .init() // массив суффиксов
    @Published var dict: [String: Int] = .init() // словарь [суффикс: количество вхождений]
    @Published var topDict: [String: Int] = .init() // словарь топ 10 [суффикс: количество вхождений]
    
    @Published var suffixForSearch: String = "" // строка для фильтрации суффиксов
    @Published var filteredSuffixArray: [String] = .init() // отфильтрованный массив суффиксов
    private var cancellableSet = Set<AnyCancellable>()
    
    /// создание массива суффиксов на основании введенного текста и заполнение словарей
    func createArray() {
        suffixArray = .init() // обнуляем
        
        let suffixSequense = SuffixSequence(text: text)
        for suffix in suffixSequense {
            suffixArray.append(suffix)
        }
        
        setDict(with: suffixArray)
    }
   
    /// заполняем словарь и вызываем заполнение топ 10 суффиксов
    func setDict(with array: [String]) {
        dict = .init() // обнуляем словарь
        
        // заполняем словарь суффиксов с количеством вхожнений суффиксов в строке
        for str in array {
            var count = 0
            for str2 in array {
                if str2.contains(str) {
                    count += 1
                }
                
            }
            dict[str] = count
        }
        
        // заполняем словарь топ 10
        topDict = .init()
        var array = Array(dict.keys.sorted(by: { dict[$0]! > dict[$1]! }).prefix(10))
        for key in array {
            topDict[key] = dict[key]
        }
    }
    
    init() {
        $suffixForSearch
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { value in
                var filteredArray: [String] = .init()
                for suffix in self.suffixArray {
                    if suffix.contains(value) {
                        filteredArray.append(suffix)
                    }
                }
                
                if filteredArray.isEmpty { 
                    self.setDict(with: self.suffixArray)
                } else {
                    self.setDict(with: filteredArray)
                }
                return filteredArray
            }
            .assign(to: \.filteredSuffixArray, on: self)
            .store(in: &cancellableSet)
        
    }
}
