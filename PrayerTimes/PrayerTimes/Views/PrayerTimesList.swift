//
//  PrayerTimeRowView.swift
//  PrayerTimes
//
//  Created by user on 01/10/2020.
//

import SwiftUI

struct PrayerTimesList: View {
    
    @Binding var prayers: [Prayer]
    
    var body: some View {
        
        VStack(spacing: 0) {
            ForEach(prayers) { prayer in
                HStack {
                    Text(prayer.name)
                    Spacer()
                    Text("\(prayer.formattedTime)")
                }
                .padding(.all, 20)
                .background(prayer.isNextPrayer ? Color.blue.opacity(0.5) : Color.clear)
            }
        }
    }
}
