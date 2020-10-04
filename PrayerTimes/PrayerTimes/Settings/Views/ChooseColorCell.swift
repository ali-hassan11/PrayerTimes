//
//  ChooseColorCell.swift
//  PrayerTimes
//
//  Created by user on 05/10/2020.
//

import SwiftUI

struct ChooseColorCell: View {
    
    var title: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text(title).font(.body)
            Spacer()
            Button(action: action) {
                RoundedRectangle(cornerRadius: 8, style: .continuous).frame(width: 30, height: 30)
            }
        }
    }
}
