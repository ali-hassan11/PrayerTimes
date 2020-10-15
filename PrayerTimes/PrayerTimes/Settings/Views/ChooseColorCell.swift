//
//  ChooseColorCell.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

struct ChooseColorCell: View {
    
    @Binding var colorScheme: Color

    var title: String
    var action: () -> Void
    
    @State var isColorPickerPresented = false
        
    var body: some View {
        HStack {
            Text(title).font(.body)
            Spacer()
            Button(action: {
                isColorPickerPresented.toggle()
            }) {
                Rectangle()
                    .cornerRadius(5)
                    .frame(width: 30, height: 30)
            }
        }
        .sheet(isPresented: $isColorPickerPresented) {
            ColorPickerView(colorScheme: $colorScheme, isColorPickerPresented: $isColorPickerPresented)
        }
    }
}
