//
//  PrayerTimeCell.swift
//  PrayerTimes
//
//  Created by user on 03/10/2020.
//

import SwiftUI

struct PrayerTimeCell:  View {

    var prayer: Prayer
    var viewModel: PrayerTimeListViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Text(prayer.name)
                .font(.title3).fontWeight(.medium)
            Spacer()
            if prayer.isNextPrayer {
                Text(viewModel.timeRemainingString)
                    .font(.subheadline)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                Spacer()
            }
            Text("\(prayer.formattedTime)")
                .font(.title3).fontWeight(.medium)
            Image(systemName: "bell.fill")
                .padding(.leading, 10)
        }
        .padding(.all, 20)
        .background(prayer.isNextPrayer ? Color(UIColor.systemPink) : Color(UIColor.tertiarySystemFill))
//        .cornerRadius(5)
        .foregroundColor(prayer.isNextPrayer ? Color(UIColor.white) : Color(UIColor.label).opacity(0.8))
        .onReceive(timer) { _ in
            viewModel.updateTimeRemaining()
        }
    }
}
