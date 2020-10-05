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
                    .padding(.horizontal, 10)
                    .minimumScaleFactor(0.8)
            }
            Text("\(prayer.formattedTime)")
                .font(.title3).fontWeight(.medium)
            Image(systemName: "bell.fill")
                .padding(.leading, 20)
        }
        .padding(.all, 20)
        .background(prayer.isNextPrayer ? Color(UIColor.systemPink) : Color(UIColor.tertiarySystemBackground))
        .cornerRadius(5)
        .foregroundColor(prayer.isNextPrayer ? Color(UIColor.white) : Color(UIColor.label).opacity(0.8))
        .onReceive(timer) { time in
            guard viewModel.timeRemaining != nil else { return }
            if viewModel.timeRemaining! > 0 {
                viewModel.timeRemaining! -= 1
            } else {
                viewModel.timeRemaining = 0
            }
        }
    }
}
