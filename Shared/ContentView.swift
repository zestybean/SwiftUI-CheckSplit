//
//  ContentView.swift
//  Shared
//
//  Created by Brando Lugo on 12/14/20.
//

import SwiftUI

//View
struct ContentView: View {
    
    //State is used because we are expecting users to enter data into our app
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var grandTotal: Double {
        //Calc the grand total here
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        //Calc the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {

            NavigationView {
                    Form {
                        Section {
                            HStack {
                                TextField("Enter Check Amount", text: $checkAmount)
                                    .keyboardType(.decimalPad)
                                
                                Button("Submit") {
                                    self.hideKeyboard()
                                }
                            }
                            
                            
                            Picker("Number of people", selection: $numberOfPeople) {
                                ForEach(2..<100){
                                    Text("\($0)")
                                }
                            }
                        }
                        
                        Section(header: Text("Slide to choose a tip amount")) {
                            Picker("Tip percentage", selection: $tipPercentage) {
                                ForEach(0..<tipPercentages.count) {
                                    Text("\(self.tipPercentages[$0])%")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Grand total with tip")) {
                            Text("$\(grandTotal, specifier: "%.2f")")
                        }
                        
                        Section(header: Text("Total amount per person")) {
                            Text("$\(totalPerPerson, specifier: "%.2f")")
                        }
                    }
                    .navigationTitle("WeSplit ☇")
            }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
