//
//  ContentView.swift
//  Shared
//
//  Created by Brando Lugo on 12/14/20.
//

import SwiftUI

struct ContentView: View {
    
    //State is used because we are expecting users to enter data into our app
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $checkAmount)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
