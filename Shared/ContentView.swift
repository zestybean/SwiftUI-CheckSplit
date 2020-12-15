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
    
    var totalPerPerson: Double {
        //Calc the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        Background {
            NavigationView {
                    Form {
                        Section {
                            TextField("Enter Check Amount", text: $checkAmount)
                                .keyboardType(.decimalPad)
                            
                            Picker("Number of people", selection: $numberOfPeople) {
                                ForEach(2..<100){
                                    Text("\($0)")
                                }
                            }
                        }
                        
                        Section(header: Text("Please choose a tip amount")) {
                            Picker("Tip percentage", selection: $tipPercentage) {
                                ForEach(0..<tipPercentages.count) {
                                    Text("\(self.tipPercentages[$0])%")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("Total amount per person")) {
                            Text("$\(totalPerPerson, specifier: "%.2f")")
                        }
                    }
                    .navigationTitle("WeSplit")
            }
        }  .onTapGesture {
            self.endEditing()
        }
      
        
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        Color.white
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
