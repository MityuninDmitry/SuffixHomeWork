//
//  ContentView.swift
//  SuffixHomeWork
//
//  Created by Dmitry Mityunin on 9/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var asc: Bool = true // сортировка 
    @State var mode = 0
    var body: some View {
        VStack {
            TextField("Enter some text", text: $viewModel.text)
                .textInputAutocapitalization(.never)
            
            Picker("MODE", selection: $mode) {
                Text("ALL suffixes").tag(0)
                Text("TOP suffixes").tag(1)
            }
            .pickerStyle(.segmented)
            
            switch mode {
            case 0:
                List {
                    ForEach(Array(viewModel.dict.keys.sorted(by: { !asc ? $0 > $1 : $0 < $1})), id: \.self) { key in
                        Text("\(key): \(viewModel.dict[key]!)")
                    }
                    
                    
                }
                .listStyle(.plain)
                
                Spacer()
                
                Button {
                    asc.toggle()
                } label: {
                    if asc == true {
                        Text("CURRENT SORT IS ASC")
                    } else {
                        Text("CURRENT SORT IS DESC")
                    }
                    
                }
            case 1:
                List {
                    ForEach(Array(viewModel.dict.keys.sorted(by: { viewModel.dict[$0]! > viewModel.dict[$1]! }).prefix(10)), id: \.self) { key in
                        Text("\(key): \(viewModel.dict[key]!)")
                    }
                }
                .listStyle(.plain)
                
                Spacer()
            default:
                Text("def")
            }
            
            
            Spacer()
            Text("Search suffix")
            TextField("Search sfuffix", text: $viewModel.suffixForSearch)
                .textInputAutocapitalization(.never)
                
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}

struct StringSequence: Sequence, IteratorProtocol {
    var text: String
    
    mutating func next() -> Int? {
        return 4
    }
    
    
}
