//
//  ColorPickerView.swift
//  PrayerTimes
//
//  Created by user on 15/10/2020.
//

import SwiftUI



struct ColorPickerView: View {
    let colors: [Color] = [ .init(.systemGreen), .init(.systemBlue), .init(.systemIndigo), .init(.systemPurple), .init(.systemPink), .init(.systemRed), .init(.systemOrange)]
    
    @Binding var colorScheme: Color
    @Binding var isColorPickerPresented: Bool
    
    var body: some View {
        
        NavigationView{
            VStack {
                        
                VStack {
                    Text("Current selection:")
                    Capsule(style: .continuous).foregroundColor(colorScheme)
                        .frame(height: 50)
                }
                
                Capsule(style: .continuous).frame(height: 0.5).foregroundColor(.init(.label))
                    .padding()
                
                ForEach(colors, id: \.hashValue) { color in
                    Capsule(style: .continuous).foregroundColor(color)
                        .frame(height: 50)
                        .onTapGesture(perform: {
                            colorScheme = color
                            isColorPickerPresented.toggle()
                        })
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Choose Color", displayMode: .inline)
        }
    }
}
