//
//  ColorPickerView.swift
//  PrayerTimes
//
//  Created by user on 15/10/2020.
//

import SwiftUI



struct ColorPickerView: View {
    let colors: [Color] = [ .init(.systemPink), .init(.systemRed), .init(.systemOrange), .init(.systemGreen), .init(.systemBlue), .init(.systemIndigo), .init(.systemPurple)]
    
    @Binding var colorScheme: Color
    @Binding var isColorPickerPresented: Bool
    
    var body: some View {
        
        NavigationView{
            VStack {
                        
                ZStack {
                    Capsule(style: .continuous).foregroundColor(colorScheme)
                        .frame(height: 50)
                    Text("Current selection").fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .padding(.top)
                
                Capsule(style: .continuous).frame(height: 0.5).foregroundColor(.init(.label))
                    .padding()
                
                ForEach(colors, id: \.hashValue) { color in
                    Capsule(style: .continuous).foregroundColor(color)
                        .frame(height: 50)
                        .onTapGesture(perform: {
                            colorScheme = color
//                            SettingsConfiguration.shared.saveColorSetting(color)
                        })
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Theme", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done", action: {
                isColorPickerPresented.toggle()
            })
            .foregroundColor(colorScheme)
            )
        }
    }
}
