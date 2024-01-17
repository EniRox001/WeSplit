//
//  ContentView.swift
//  WeSplit
//
//  Created by Ehnamuram Enoch on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalCheckAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack(root: {
            Form(content: {
                Section(content: {
                    TextField(value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"), label: {
                        Text("Amount")
                    })
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker(selection: $numberOfPeople, content: {
                        ForEach(2..<100) { people in
                            Text("\(people) people")
                        }
                    }, label: {
                        Text("Number of People")
                    })
                    .pickerStyle(.navigationLink)
                })
                Section("How much do you want to tip",content: {
                    Picker(selection: $tipPercentage, content: {
                        ForEach(tipPercentages, id: \.self) { percent in
                            Text(percent, format: .percent)
                        }
                    }, label: {
                        Text("Tip percentage")
                    })
                    .pickerStyle(.segmented)
                })
                Section("Amount per person", content: {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                })
                Section("Total Check Amount", content: {
                    Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                })
            })
            .navigationTitle("WeSplit")
            .toolbar(content: {
                amountIsFocused ? Button(action: {
                    amountIsFocused = false
                }, label: {
                    Text("Done")
                }) : nil
            })
        })
    }
}

#Preview {
    ContentView()
}
