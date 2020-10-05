//
//  PrayerTimeCell.swift
//  PrayerTimes
//
//  Created by user on 03/10/2020.
//

import SwiftUI

struct PrayerTimeCell:  View {

    var prayer: Prayer
    
    var body: some View {
        HStack {
            Text(prayer.name)
                .font(.title3).fontWeight(.medium)
            Spacer()
            Text("\(prayer.formattedTime)")
                .font(.title3).fontWeight(.medium)
            Image(systemName: "bell.fill")
                .padding(.leading, 20)
        }
        .padding(.all, 20)
        .background(prayer.isNextPrayer ? Color(UIColor.systemPink) : Color(UIColor.tertiarySystemBackground))
        .cornerRadius(5)
        .foregroundColor(prayer.isNextPrayer ? Color(UIColor.white) : Color(UIColor.label).opacity(0.8))
    }
}
