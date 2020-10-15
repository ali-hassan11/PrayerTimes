//
//  ChooseColorCell.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

struct ChooseColorCell: View {
    
    var title: String
    @Binding var color: Color
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(title).font(.body)
            Spacer()
            Button(action: action) {
                ColorPicker("", selection: $color, supportsOpacity: false)
            }
        }
    }
}
