//
//  ContentView.swift
//  ConversionChallenge
//
//  Created by Leo Chung on 11/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "Meters"
    @State private var outputUnit = "Kilometers"
    @State private var inputAmount = 0.0
    @FocusState private var amountIsFocused: Bool
    let inputFields = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    let outputFields = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    var output: String {
        let inputConversion = switch inputUnit {
        case "Kilometers":
            Measurement(value: inputAmount, unit: UnitLength.kilometers)
        case "Feet":
            Measurement(value: inputAmount, unit: UnitLength.feet)
        case "Yards":
            Measurement(value: inputAmount, unit: UnitLength.yards)
        case "Miles":
            Measurement(value: inputAmount, unit: UnitLength.miles)
        default:
            Measurement(value: inputAmount, unit: UnitLength.meters)
        }
        
        let outputConversion = switch outputUnit {
        case "Kilometers":
            inputConversion.converted(to: .kilometers)
        case "Feet":
            inputConversion.converted(to: .feet)
        case "Yards":
            inputConversion.converted(to: .yards)
        case "Miles":
            inputConversion.converted(to: .miles)
        default:
            inputConversion.converted(to: .meters)
        }
        
        return "\(outputConversion)"
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input Amount") {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section("Input Units") {
                    Picker("Input Field", selection: $inputUnit) {
                        ForEach(inputFields, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output Units") {
                    Picker("Output Field", selection: $outputUnit) {
                        ForEach(outputFields, id:\.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Converted Amount") {
                    Text("\(output)")
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
